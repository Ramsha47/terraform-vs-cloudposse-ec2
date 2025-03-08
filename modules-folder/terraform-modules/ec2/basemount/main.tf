# Data source to fetch VPC ID from the subnet
data "aws_subnet" "selected" {
  id = var.public_subnet_id
}

# Bastion Host (Public Subnet)
resource "aws_instance" "bastion_host" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              EOF

  tags = {
    Name = "${var.name}-bastion"
  }
}

# Create a security group for the bastion host
resource "aws_security_group" "bastion_sg" {
  vpc_id = data.aws_subnet.selected.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust for more restrictive access if needed
  }

  tags = {
    Name = "bastion-security-group"
  }
}


