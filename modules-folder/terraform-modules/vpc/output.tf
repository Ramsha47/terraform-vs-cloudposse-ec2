output "id" {
  value       = module.vpc01.vpc_id
  description = "VPC ID"
}

output "cidr" {
  value       = module.vpc01.vpc_cidr_block
  description = "VPC CIDR"
}

output "public_subnet_ids" {
  value       = zipmap(var.availability_zones, module.dynamic_subnets.public_subnet_ids)
  description = "Public subnet IDs mapped to their availability zones"
}

output "public_subnet_cidrs" {
  value       = module.dynamic_subnets.public_subnet_cidrs
  description = "Public subnet CIDRs"
}

output "private_subnet_ids" {
  value       = zipmap(var.availability_zones, module.dynamic_subnets.private_subnet_ids)
  description = "Private subnet IDs mapped to their availability zones"
}

output "private_subnet_cidrs" {
  value       = module.dynamic_subnets.private_subnet_cidrs
  description = "Private subnet CIDRs"
}
