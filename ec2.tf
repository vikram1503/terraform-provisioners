resource "aws_instance" "db" {

    ami = "ami-090252cbe067a9e58"
    vpc_security_group_ids = ["sg-07832342d5cdd6bb4"]
    instance_type = "t2.micro"

    provisioner "local-exec" {
        command = "echo ${self.private_ip} > private_ips.txt"
    }

     provisioner "local-exec" {
        command = "ansible-playbook -i private_ips.txt web.yaml"
    }

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "Devops321"
        host     = self.public_ip
    }

      provisioner "remote-exec" {
      inline = [
        "sudo dnf install ansible -y",
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx"

    ]
  }
}

