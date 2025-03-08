module "basemount" {
  source         = "../terraform-modules/ec2/basemount"
  name           = var.basemount_name
  ami            = var.ami
  key_name       = module.keypair.ec2_keypair_name
  private_subnet_id = module.vpc01.private_subnet_ids[var.availability_zones[0]]
  public_subnet_id = module.vpc01.public_subnet_ids[var.availability_zones[0]]
}