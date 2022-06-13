output "web_instance_ip" {

  value = aws_instance.web-server.public_ip
}

output "web_instance_private_ip"{

    value = aws_instance.web-server.private_ip
}