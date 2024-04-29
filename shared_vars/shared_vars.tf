output "env_suffix" {
  value = local.env
}
output "iamprofile" {
    value = local.iamprofile
}
output "rdsinstancetype" {
  value = local.rdsinstancetype
}
output "ec2instancetype" {
    value = local.ec2instancetype
}
output "ec2keypairname" {
    value = local.ec2keypairname
}
output "elbminnode" {
    value = local.elbminnode
}
output "elbmaxnode" {
    value = local.elbmaxnode
}









## ENV setup for local
locals {
  env="${terraform.workspace}"

  ##IAM access key profile
  iamprofile_env={
      default="project-dev"
      staging="project-stag"
      production="project-prod"
  }
  iamprofile="${lookup(local.iamprofile_env, local.env)}"

  ##RDS Instance class env
  rdsinstancetype_env= {
      default="db.t3.micro"
      staging="db.t3.micro"
      production="db.m5.large"
  }
  rdsinstancetype="${lookup(local.rdsinstancetype_env, local.env)}"

  ##Beanstalk Node Instance class env

  ec2instancetype_env= {
      default="t3.micro"
      staging="t3.micro"
      production="m5.large"
  }
  ec2instancetype="${lookup(local.ec2instancetype_env, local.env)}"

  ## Beanstalk Node Pem File


  ec2keypairname_env= {
      default="aws_project_tf_kp_staging"
      staging="aws_project_tf_kp_staging"
      production="aws_project_tf_kp_staging"
  }
  ec2keypairname="${lookup(local.ec2keypairname_env, local.env)}"



  ## Beanstalk autoscal node min and max

  elbminnode_env={
      default="1"
      staging="1"
      production="4"
  }
  elbminnode=lookup(local.elbminnode_env,local.env)

  elbmaxnode_env={
      default="1"
      staging="2"
      production="8"
  }
  elbmaxnode=lookup(local.elbmaxnode_env,local.env)

}