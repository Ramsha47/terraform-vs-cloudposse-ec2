module "keypair" {
  source     = "../terraform-modules/ec2/keypair"
  key_name   = var.keypair_name
}