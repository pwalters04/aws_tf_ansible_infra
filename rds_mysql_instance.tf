#Resoruce: RDS MYSQl 
resource "aws_vpc" "vpc-rds" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
        name = "rds-vpc"
    }
}


resource "aws_db_subnet_group" "rds-subnet"{
    name = "rds-subnet-group"  
    subnet_ids = "${aws_subnet.public.*.id}"
    
    tags = {
    Name = "My_DB_subnet_group"
  }
}

resource "aws_security_group" "rds-security-group" {
    name = "rds-sg"
    vpc_id ="${aws_vpc.vpc-rds.id}"
    tags = {
      name = "rds-sg"
  }
}

resource "aws_security_group_rule" "mysql_inbound_access" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = "${aws_security_group.rds-security-group.id}"
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_instance" "my_rds_mysql" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "${var.rds_instance_class}"
  name                        = "${var.database_name_Dev}"
  username                    = "${var.database_user}"
  password                    = "${var.database_temp_password}"
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = "${aws_db_subnet_group.rds-subnet.name}"
  vpc_security_group_ids      = ["${aws_security_group.rds-security-group.id}"]
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = true
  skip_final_snapshot         = true
}
