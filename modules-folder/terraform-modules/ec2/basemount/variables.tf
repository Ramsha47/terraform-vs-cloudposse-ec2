variable "ami" {
  description = "Amazon Linux AMI in the target region."
  type        = string
}

variable "name" {
  description = "Name used for instance, IAM role, and security group."
  type        = string
}

variable "public_subnet_id" {
  description = "Target public subnet ID for deployment."
  type        = string
}

variable "private_subnet_id" {
  description = "Target Private subnet ID for deployment."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all stack resources."
  default     = {}
  type        = map(any)
}