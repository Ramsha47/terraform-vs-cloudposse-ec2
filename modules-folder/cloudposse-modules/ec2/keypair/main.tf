# Generate a private key and public key pair within Terraform
resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create the AWS key pair using the generated public key
resource "aws_key_pair" "bastion_key" {
  key_name   = "${var.key_name}-bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.bastion_key.private_key_pem
  filename = "~/.ssh/bastion_key.pem" # Saves to ~/.ssh/
}