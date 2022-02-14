/********************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform Environment Variables
 *
 * Location: env/.tfvars
 *
 * Description:
 *  - Environment variables used in generating
 *    cloud infrastructure 
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ********************************************************/

# AWS REGION
region = "us-east-1"

# VPC SPECIFIC VARIABLES
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]

# SUBNET SPECIFIC VARIABLES
public_subnets   = ["10.0.10.0/24", "10.0.20.0/24"]
private_subnets  = ["10.0.30.0/24", "10.0.40.0/24"]

# APP SPECIFIC VARIABLES
environment = "production"
app_name    = "graylog"
owner       = "devops"

# INSTANCE SPECIFIC VARIABLES
instance_type             = "t3.medium"
instance_min_size         = "1"
instance_max_size         = "4"
instance_desired_capacity = "2"