terraform {
  required_version = ">=1.14"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.33.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.26.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  config_path    = var.kubernetes.config_path
  config_context = var.kubernetes.config_context
}

data "aws_ssm_parameter" "env" {
  name = var.db_credentials_ssm_path
}

locals {
  db_credentials = {
    for line in split("\n", data.aws_ssm_parameter.env.value) :
    split("=", line)[0] => join("=", slice(split("=", line), 1, length(split("=", line))))
  }
}

provider "postgresql" {
  host     = local.db_credentials["DB_HOST"]
  port     = try(local.db_credentials["DB_PORT"], 5432)
  username = local.db_credentials["DB_USER"]
  password = local.db_credentials["DB_PASSWORD"]
  sslmode  = "disable"
}