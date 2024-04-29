module "shared_vars" {
  source = "../shared_vars"
}




resource "aws_elastic_beanstalk_application" "project-app" {
  name        = "project-app-${module.shared_vars.env_suffix}"
  description = "Flyarna APP for ${module.shared_vars.env_suffix}"
}

resource "aws_elastic_beanstalk_environment" "project-env" {
  name                = "project-env-${module.shared_vars.env_suffix}"
  application         = aws_elastic_beanstalk_application.project-app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.11 running PHP 7.4"
  
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = module.shared_vars.ec2instancetype
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = module.shared_vars.ec2keypairname
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeSize"
    value     = "10"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = module.shared_vars.elbminnode
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = module.shared_vars.elbmaxnode
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = "CPUUtilization"
  }
  setting {
    namespace = "aws:autoscaling:trigger" 
    name      = "Statistic"
    value     = "Average"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = "Percent"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = "20"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = "70"
  }
}
