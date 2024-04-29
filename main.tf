provider "aws" {
 region     = "ap-south-1"
 profile = "${module.shared_vars.iamprofile}"
}

## Loading each module

module "rds_module" {
  source = "./rds_module"
}

module "efs_module" {
  source = "./efs_module"
}

module "elb_module" {
  source = "./elb_module"
}

module "waf_module" {
  source = "./waf_module"
}

module "shared_vars" {
  source = "./shared_vars"
}

##Storing terraform state to S3

terraform {
backend "s3" {
      bucket         = "project-terraform-state"
      key            = "project/terraform.tfstate"
      region         = "ap-south-1"
      profile        = "project"     
}
}