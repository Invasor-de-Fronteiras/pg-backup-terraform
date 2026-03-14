
resource "postgresql_role" "backup_user" {
  name     = var.name
  login    = true
  password = random_password.backup_user.result
  roles    = ["pg_read_all_data"]
}

resource "postgresql_grant" "backup_connect" {
  database    = var.db_name
  role        = postgresql_role.backup_user.name
  object_type = "database"
  privileges  = ["CONNECT"]
}

resource "postgresql_grant" "backup_schema" {
  database    = var.db_name
  role        = postgresql_role.backup_user.name
  schema      = "public"
  object_type = "schema"
  privileges  = ["USAGE"]
}

resource "postgresql_grant" "backup_tables" {
  database    = var.db_name
  role        = postgresql_role.backup_user.name
  schema      = "public"
  object_type = "table"
  privileges  = ["SELECT"]
}

resource "postgresql_grant" "backup_sequences" {
  database    = var.db_name
  role        = postgresql_role.backup_user.name
  schema      = "public"
  object_type = "sequence"
  privileges  = ["SELECT"]
}
