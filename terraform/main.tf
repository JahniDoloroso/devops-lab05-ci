provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "lab05" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  tags = {
    Name    = "lab05-instance"
    Project = "lab05"
  }
}