variable "name" {
  description = "Base name used to identify all created resources (S3 bucket, IAM user, PostgreSQL role, Kubernetes secret and cronjob)."
  type        = string
}

variable "kubernetes" {
  description = "Kubernetes cluster access configuration where the backup cronjob will be deployed."
  type = object({
    namespace      = string
    config_context = string
    config_path    = string
  })
}

variable "pg_backup_image" {
  description = "Docker image used by the cronjob to run the PostgreSQL backup."
  type        = string
  default     = "ghcr.io/invasor-de-fronteiras/pg-backup-script:1.0.0"
}

variable "db_name" {
  description = "Name of the PostgreSQL database to back up."
  type        = string
}

variable "ssm_db_pass_path" {
  description = "AWS SSM Parameter Store path where the generated backup user password will be stored."
  type        = string
}

variable "db_credentials_ssm_path" {
  description = "AWS SSM Parameter Store path containing database credentials in KEY=VALUE format, used to configure the PostgreSQL provider. Expected keys: DB_HOST, DB_USER, DB_PASSWORD, and optionally DB_PORT."
  type        = string
}

variable "aws_region" {
  description = "AWS region where resources (S3, IAM, SSM) will be created."
  type        = string
  default     = "us-east-1"
}

variable "db_host" {
  description = "PostgreSQL host exposed to the backup cronjob via Kubernetes secret."
  type        = string
}

variable "schedule" {
  description = "Cron expression defining the backup frequency (e.g. '@daily', '0 3 * * *')."
  type        = string
  default     = "@daily"
}

variable "additional_environments" {
  description = "Extra environment variables to inject into the Kubernetes secret, merged with the default backup variables."
  type        = map(string)
  default     = {}
}
