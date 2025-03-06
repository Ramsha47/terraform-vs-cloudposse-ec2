module "vpc" {
  source                   = "./vpc"
  availability_zones       = var.availability_zones
  common_tags              = var.common_tags
  vpc01_name               = var.vpc01_name
  vpc01_cidr               = var.vpc01_cidr
  vpc01_public_cidr_az01   = var.vpc01_public_cidr_az01
  vpc01_private_cidr_az01  = var.vpc01_private_cidr_az01
  vpc01_public_cidr_az02   = var.vpc01_public_cidr_az02
  vpc01_private_cidr_az02  = var.vpc01_private_cidr_az02
  vpc01_public_cidr_az03   = var.vpc01_public_cidr_az03
  vpc01_private_cidr_az03  = var.vpc01_private_cidr_az03  
}

module "basemount" {
  source         = "./ec2/basemount"
  name           = var.basemount_name
  ami            = var.ami
  private_subnet_id = module.vpc01.private_subnet_ids[var.availability_zones[0]]
  public_subnet_id = module.vpc01.public_subnet_ids[var.availability_zones[0]]
  vpc_cidr       = var.vpc01_cidr
  vpc_id         = module.vpc01.id
  common_tags = var.common_tags
}