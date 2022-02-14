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


/********************************************************************************************
 *********************************** NEEDS TO BE UPDATED ***********************************/

# AWS REGION
# e.g. us-east-1
region = "" 

# AVAILABILITY ZONES
# e.g. ["us-west-1a", "us-west-1c"]
availability_zones = []

# WILDCARD CERT ARN
# Note: Certificate ARN has to belong to the same regions as the region variable above
# e.g. arn:aws:acm:us-east-1:123456789:certificate/234iuhf46-awef-481b-9232-1234567890abc
certificate_arn = ""

# ROUTE53 HOSTED ZONE ID
# e.g. Z1234567890ABCDEFG
route53_zone_id = ""

# DNS RECORD NAME
# e.g. hello-graylog.fakedomain.com
route53_dns_record_name = ""

/********************************************************************************************
 ********************************************************************************************/


# VPC SPECIFIC VARIABLES
vpc_cidr           = "10.0.0.0/16"

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