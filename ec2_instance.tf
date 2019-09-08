#Resource: EC2 Intance 

resource "aws_instance" "ec2Box" {
    ami = "${var.ami_server}"
    instance_type = "${var.instance_type}"
    
    tags ={
        Name = "EC2Box"
    }
}
