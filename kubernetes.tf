resource "kubernetes_secret_v1" "credentials" {
  metadata {
    name      = "${var.name}-backup-credentials"
    namespace = var.kubernetes.namespace
  }

  data = {
    AWS_ACCESS_KEY_ID     = aws_iam_access_key.backup.id
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.backup.secret
    PG_DB                 = var.db_name
    PG_HOST               = var.db_host
    PG_USER               = postgresql_role.backup_user.name
    PG_PASSWORD           = random_password.backup_user.result
    PGPASSWORD            = random_password.backup_user.result
    S3_BUCKET             = aws_s3_bucket.backup.bucket
    S3_REGION             = var.aws_region
  }
}

resource "kubernetes_cron_job_v1" "pg_backup" {
  metadata {
    name      = "${var.name}-backup-cronjob"
    namespace = var.kubernetes.namespace
  }

  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 1
    schedule                      = "@daily"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10

    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name  = "pg-backup"
              image = var.pg_backup_image
              env_from {
                secret_ref {
                  name = kubernetes_secret_v1.credentials.metadata[0].name
                }
              }
            }
          }
        }
      }
    }
  }
}