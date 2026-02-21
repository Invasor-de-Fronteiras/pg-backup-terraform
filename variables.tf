variable "name" {
  type = string
}

variable "kubernetes" {
  type = object({
    namespace      = string
    config_context = string
    config_path    = string
  })
}

variable "pg_backup_image" {
  type    = string
  default = "ghcr.io/invasor-de-fronteiras/pg-backup-script:1.0.0"
}

variable "db_name" {
  type = string
}

variable "ssm_db_pass_path" {
  type = string
}

variable "db_credentials_ssm_path" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "db_host" {
  type = string
}