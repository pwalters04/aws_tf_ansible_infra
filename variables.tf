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
    default = "OpsUser"
}
variable "key_path" {
  default ="tf_exercise.pem"
}



