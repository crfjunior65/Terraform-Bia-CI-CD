resource "random_password" "db_master_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "db_password_secret" {
  name        = "${var.environment}-rds-master-password"
  description = "Master password for the ${var.environment} RDS database."
  tags = {
    "Environment" = "Projeto_${var.environment}"
    "Management"  = "Terraform"
    "Name"        = "secret-db-${var.environment}"
    "Terraform"   = "true"
  }
}

resource "aws_secretsmanager_secret_version" "db_password_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_password_secret.id
  secret_string = random_password.db_master_password.result
}