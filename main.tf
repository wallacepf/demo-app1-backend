terraform {
  required_providers {
    aws = {
      version = "~>3.0"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "myterraformcloud"
    workspaces = {
      name = "demo-app1-nw"
    }
  }
}

data "terraform_remote_state" "db" {
  backend = "remote"
  config = {
    organization = "myterraformcloud"
    workspaces = {
      name = "demo-app1-db"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_string" "random" {
  length  = 8
  upper   = false
  special = false
}

module "backend" {
  source  = "app.terraform.io/myterraformcloud/backend/aws"
  version = "~>1.0.0"

  key_name = "tf_lab_key"

  app_s3_addr   = var.app_url
  db_address    = data.terraform_remote_state.db.outputs.db_address
  backend_name  = "backend-${random_string.random.id}"
  instance_type = var.backend_instance_type

  backend_subnets = data.terraform_remote_state.vpc.outputs.public_subnets
  security_group  = data.terraform_remote_state.vpc.outputs.backend_security_group_id

  tags = var.common_tags
}
