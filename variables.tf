variable "azs" {
	type = "list"
	default = ["us-east-1a", "us-east-1b"]
}
variable "ami_server" {
  default ="ami-035b3c7efe6d061d5"
}

variable "instance_type" {
  default = "t2.micro"
}