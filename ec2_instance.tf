#Resource: EC2 Intance 

# resource "aws_key_pair" "tf_exercise" {
#     key_name="tf_exercise"
#     public_key ="${file("tf_exercise.pem")}"
# }
resource "aws_instance" "ec2Box" {
    count = "${var.instance_count}"
    ami = "${var.ami_server}"
    instance_type = "${var.instance_type}"
    vpc_security_group_ids = ["${aws_security_group.sg_80.id}"]
    iam_instance_profile ="${aws_iam_instance_profile.ec2_profile.name}"
    key_name = "${var.key_pair_name}"
    monitoring = true
    user_data ="${file("apache_install.sh")}"
    tags ={
        Name = "EC2Box-${count.index +1}"
    }
}

resource "aws_security_group" "sg_80" {
  name = "sg_80"
  
  ingress {
      from_port = 8080
      to_port = 8080
      protocol ="tcp"
      cidr_blocks =["0.0.0.0/0"]
  }

  ingress {
      from_port = 3306
      to_port = 3306
      protocol ="tcp"
      cidr_blocks =["0.0.0.0/0"]
  }
}

