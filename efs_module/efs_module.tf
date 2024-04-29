module "shared_vars" {
    source = "../shared_vars"
}


resource "aws_efs_file_system" "efs" {
   creation_token = "project-${module.shared_vars.env_suffix}"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name = "project-${module.shared_vars.env_suffix}"
   }
 }