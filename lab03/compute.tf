resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.lab_subnet_a.id

  vpc_security_group_ids = [aws_security_group.lab_sg.id]

  tags = {
    Name = "Lab03-EC2"
  }
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}