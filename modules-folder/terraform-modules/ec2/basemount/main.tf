# Bastion Host (Public Subnet)
resource "aws_instance" "bastion_host" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.name}-bastion"
  }
}