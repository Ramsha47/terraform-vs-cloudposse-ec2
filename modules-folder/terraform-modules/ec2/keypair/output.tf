output "ec2_keypair_name" {
  description = "EC2 SSH KeyPair Name"
  value       = aws_key_pair.bastion_key.key_name
}

output "private_key_pem_content" {
  description = "private key pem content"
  value = tls_private_key.bastion_key.private_key_pem
}