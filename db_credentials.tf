resource "random_password" "backup_user" {
  length  = 16
  special = false
}

resource "aws_ssm_parameter" "backup_user_password" {
  name  = var.ssm_db_pass_path
  type  = "SecureString"
  value = random_password.backup_user.result
}
