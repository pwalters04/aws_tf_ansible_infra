#Resource Setup

resource "null_resource" "AnsibleSetup" {
   provisioner "local-exec" {
    command = "echo [${var.dev_host_label}:vars] > hosts"
  }

    provisioner "local-exec"{
        command = "echo ansible_ssh_user=${var.ssh_user_name} >> hosts"
    }
      provisioner "local-exec" {
    command = "echo [${var.dev_host_label}] >> hosts"
  }
  
}

resource "null_resource" "Ansible_key_path" {
  provisioner "local-exec"{
        command = "echo ansible_ssh_private_key_file=${var.key_path} >> hosts"
    }

}


resource "null_resource" "AnsibleConnect" {
    count = "${var.instance_count}"
    connection{
        type ="ssh"
        user ="${var.ssh_user_name}"
        host ="${element(aws_instance.ec2Box.*.public_ip, count.index)}"
        private_key ="${file("${var.key_path}")}"
    }

    provisioner "local-exec" {
    command = "echo ${element(aws_instance.ec2Box.*.public_ip, count.index)} >> hosts"
  }

}

resource "null_resource" "HTOPInstall" {
    count = "${var.instance_count}"
    connection{
        type ="ssh"
        user ="${var.ssh_user_name}"
        host ="${element(aws_instance.ec2Box.*.public_ip, count.index)}"
        private_key ="${file("${var.key_path}")}"
    }
     provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install htop",
    ]
  }
}