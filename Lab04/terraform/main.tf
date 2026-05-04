provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "lab_key" {
  key_name   = "csdo1010-Lab04-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "lab04_sg" {
  name        = "lab04-security-group"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t3.micro"

  key_name = aws_key_pair.lab_key.key_name
  vpc_security_group_ids = [aws_security_group.lab04_sg.id]
  
  tags = {
    Name = "Lab04-EC2"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.web.public_ip}"
}