module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpcCIDR

  azs             = [var.ZONE1, var.ZONE2, var.ZONE3]
  private_subnets = [var.privsub1CIDR, var.privsub2CIDR, var.privsub3CIDR]
  public_subnets  = [var.pubsub1CIDR, var.pubsub2CIDR, var.pubsub3CIDR]

  enable_nat_gateway   = true
  enable_vpn_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}