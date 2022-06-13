provider "aws" {
  region = var.region

  access_key = var.access_key

  secret_key = var.secret_key
}


resource "aws_instance" "ubuntu_server" {
#description
instance_type = var.instance_type

ami ="ami-0aeb7c931a5a61206"

key_name = "ubuntu_instance"

user_data = <<-EOF

    #!/bin/bash

    sudo apt update
    sudo apt install openjdk-8-jdk  -y
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add 
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update 
    sudo apt install jenkins -y
    sudo systemctl start jenkins 
    sudo systemctl status jenkins > /home/ubuntu/log.txt
    

    EOF


tags = {

  name = "ubuntu_server"
}

}

resource "aws_instance" "web-server" {

  ami = var.ami

  instance_type = var.instance_type

  key_name = "ubuntu_instance"

  user_data = <<-EOF

    #!/bin/bash 
echo BEGIN
date '+%Y-%m-%d %H:%M:%S'
echo END

    EOF


  tags = {

    Name = "web_instance"


  }


}


