variable "db_username" {
  default = "admin"
}

resource "random_pet" "db_password" {
  length = 4
}

resource "aws_db_subnet_group" "lab_db_subnet" {
  name = "lab-db-subnet"

  subnet_ids = [
    aws_subnet.lab_subnet_a.id,
    aws_subnet.lab_subnet_b.id
  ]
}

resource "aws_db_instance" "lab_db" {
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"

  username = var.db_username
  password = random_pet.db_password.id

  db_subnet_group_name = aws_db_subnet_group.lab_db_subnet.name

  skip_final_snapshot = true
  publicly_accessible = true

  tags = {
    Name = "lab03-RDS"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.lab_db.endpoint
}

output "rds_password" {
  value     = aws_db_instance.lab_db.password
  sensitive = true
}