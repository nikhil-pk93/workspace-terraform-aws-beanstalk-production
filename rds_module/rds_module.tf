module "shared_vars" {
    source = "../shared_vars"
}

##RDS Launch config
resource "aws_db_instance" "rds" {
    identifier        = "project-${module.shared_vars.env_suffix}"
    allocated_storage = 20
    engine            = "mysql"
    engine_version    = "5.7"
    instance_class    = "${module.shared_vars.rdsinstancetype}"
    name              = "project_${module.shared_vars.env_suffix}"
    username          = "tfuser"
    password          = "tfadmin123db"
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot = true
    apply_immediately = true
}