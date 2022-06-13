provider "aws" {

  region     = "us-east-2"
  access_key = ""
  secret_key = ""

}


resource "aws_iam_role" "ec2_ubuntu_role" {
  name = "ec2_ubuntu_role"
  assume_role_policy = "${file("ec2_ubuntu_role.json")}"

  lifecycle {

      prevent_destroy = true
  }
}


resource "aws_iam_role_policy" "ec2_ubuntu_policy" {
  name = "ec2_ubuntu_policy"
  role = aws_iam_role.ec2_ubuntu_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  lifecycle {

      prevent_destroy = true
  }
}

resource "aws_iam_instance_profile" "ec2_ubuntu_profile" {

  name = "ec2_ubuntu_profile"

  role = aws_iam_role.ec2_ubuntu_role.name


}

resource "aws_instance" "ubuntu_server" {


  ami                  = "ami-0fa49cc9dc8d62c84"
  instance_type        = "t2.nano"
  iam_instance_profile = "ec2_ubuntu_profile"
  tags = {

    name = "ubuntu_server"
  }

}
