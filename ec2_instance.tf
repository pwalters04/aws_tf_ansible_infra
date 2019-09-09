#Resource: EC2 Intance 

resource "aws_key_pair" "tf_exercise" {
    key_name="box_access"
    public_key ="${file("tf_exercise.pem")}"
}
resource "aws_instance" "ec2Box" {
    count = "${var.instance_count}"
    ami = "${var.ami_server}"
    instance_type = "${var.instance_type}"
    iam_instance_profile ="${aws_iam_instance_profile.ec2_profile.name}"
    
    key_name = "${aws_key_pair.tf_exercise.key_name}"
    user_data ="${file("apache_install.sh")}"
    tags ={
        Name = "EC2Box"
    }
}
