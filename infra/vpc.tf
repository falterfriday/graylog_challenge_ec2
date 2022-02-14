/******************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform VPC
 *
 * Location: infra/vpc.tf
 *
 * Description:
 *  - Utilizes the AWS VPC module to provision:
 *    - VPC
 *    - Subnets (public, private, and database)
 *    - Internet Gateway
 *    - NAT Gateway + EIP
 *    - Route Tables
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ******************************************************/


/*
 * AWS VPC Module
 * Documentaion: https://registry.terraform.io/modules/terraform-aws-modules/vpc
 */
module "aws_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name = "${local.name}-vpc"
  cidr = var.vpc_cidr
  azs  = var.availability_zones

  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets

  enable_nat_gateway   = true
  create_igw           = true
  enable_dns_hostnames = true
  single_nat_gateway   = true

  vpc_tags                 = merge(local.tags, tomap({ Name = "vpc-${local.name}" }))
  igw_tags                 = merge(local.tags, tomap({ Name = "igw-${local.name}" }))
  nat_gateway_tags         = merge(local.tags, tomap({ Name = "nat-gw-${local.name}" }))
  nat_eip_tags             = merge(local.tags, tomap({ Name = "nat-eip-${local.name}" }))
  public_subnet_tags       = merge(local.tags, tomap({ Name = "subnet-public-${local.name}", Subnet = "private" }))
  private_subnet_tags      = merge(local.tags, tomap({ Name = "subnet-private-${local.name}", Subnet = "private" }))
  public_route_table_tags  = merge(local.tags, tomap({ Name = "rtbl-public-${local.name}" }))
  private_route_table_tags = merge(local.tags, tomap({ Name = "rtbl-private-${local.name}" }))
}