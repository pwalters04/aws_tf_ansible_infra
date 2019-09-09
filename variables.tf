variable "azs" {
	type = "list"
	default = ["us-east-1a", "us-east-1b"]
}
variable "ami_server" {
 description = "Ubuntu Machince 16.04"   
  default ="ami-04169656fea786776"
}

variable "instance_count" {
    default = 1
}

variable "instance_type" {
  default = "t2.nano"
}

variable "dev_host_label" {
  default = "terraform_ansible_host"
}

variable "ssh_user_name" {
    default = "ec2_role"
}
variable "key_path" {
  default ="tf_exercise.pem"
}
variable "key_pair_name" {
  default = "tf_exercise"
  
}

variable "rds_instance_class" {
  default = "db.t2.micro"
}

variable "database_name_Dev" {
  default = "sandboxSQLDB-DEV"
}
variable "database_name_QA" {
  default = "sandboxSQLDB-QA"
}

variable "database_name_Prod" {
  default = "sandboxSQLDB-QA"
}
variable "database_user" {
  default = "admin"
}

variable "vpc_cidr" {
	default = "10.10.0.0/16"
}

variable "subnets_cidr" {
	type = "list"
	default = ["10.10.1.0/24", "10.10.2.0/24"]
}
variable "database_temp_password" {
  default = "Random2019"
}



