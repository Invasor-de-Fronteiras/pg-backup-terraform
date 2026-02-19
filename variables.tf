variable "name" {
  type    = string
  default = "kelbi-pg"
}

variable "kubernetes" {
  type = object({
    namespace      = string
    config_context = string
    config_path    = string
  })
  default = {
    namespace      = "kelbi-pg"
    config_context = "arca"
    config_path    = "~/.kube/config.bk"
  }
}

variable "pg_backup_image" {
  type    = string
  default = "ghcr.io/invasor-de-fronteiras/pg-backup-script:1.0.0"
}

variable "db_name" {
  type    = string
  default = "kelbi"
}

variable "ssm_db_pass_path" {
  type    = string
  default = "/arca/kelbi-pg/backup-user/db-password"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "db_host" {
  type    = string
  default = "kelbi-pg-root-app-kelbi-pg-dev.kelbi-pg.svc.cluster.local"
}