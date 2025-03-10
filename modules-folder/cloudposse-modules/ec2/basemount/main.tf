data "aws_subnet" "selected" {
  id = var.private_subnet_id
}

module "basemount_bastion" {
  source = "cloudposse/ec2-instance/aws"
  version = "1.6.1" # Replace with the latest version if needed

  # Basic EC2 instance configuration
  ami                 = var.ami
  instance_type       = "t2.micro"
  subnet              = var.public_subnet_id
  ssh_key_pair        = var.key_name
  vpc_id              = data.aws_subnet.selected.vpc_id
  # Enable the module to create a security group
  security_group_enabled = true
  security_group_description = "Security group for bastion host"

  # Security group rules for the bastion host
  security_group_rules = [
    {
      type        = "egress"s
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    },
    {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Adjust for more restrictive access in production
      description = "Allow SSH access from anywhere"
    }
  ]

  # User data script
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              EOF

  name      = "${var.name}-bastion"
  tags = {
    Name = "${var.name}-bastion"
  }
}

module "basemount_instance" {
  source = "cloudposse/ec2-instance/aws"
  version = "1.6.1" 

  # Basic EC2 instance configuration
  ami                 = var.ami
  instance_type       = var.common_tags["environment"]=="main"? "m7i.16xlarge": "m7i.16xlarge"
  disable_api_termination = var.disable_api_termination
  ssh_key_pair        = var.key_name
  subnet              = var.private_subnet_id
  vpc_id              = data.aws_subnet.selected.vpc_id 
  associate_public_ip_address = false

  # Define security group rules within CloudPosse module
  security_group_enabled = true
  security_group_description = "Security group for private instance"
  security_group_rules = [
  {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    source_security_group_id = module.basemount_bastion.security_group_id
    cidr_blocks              = [] # No CIDR blocks used
    description              = "Allow SSH access from bastion security group"
  },
  {
    type                     = "egress"
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    source_security_group_id = null # No security group source
    cidr_blocks              = ["0.0.0.0/0"] 
    description              = "Allow all outbound traffic"
  }
]

  # CloudPosse naming inputs
  name      = var.name
  
  # Tags
  tags = { Name = "${var.name}-private" 
}