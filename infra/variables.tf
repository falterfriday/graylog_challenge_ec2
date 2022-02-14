/******************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform Data Sources
 *
 * Location: infra/data.tf
 *
 * Description:
 *  - Data sources provider
 *
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ******************************************************/

/*
 * AWS REGION
 * Used: main.tf:33
 */
variable "region" {
  type        = string
  description = "AWS region to provision assets"
}

/*
 * VPC CIDR BLOCK
 * Used: vpc.tf:29
 */
variable "vpc_cidr" {
  type        = string
  description = "vpc cidr block"
}

/*
 * AVAILABILITY ZONES
 * Used: vpc.tf:30
 */
variable "availability_zones" {
  type        = list(string)
  description = "availability zones"
}

/*
 * CERTIFICATE ARN
 * Used: vpc.tf:30
 */
variable "certificate_arn" {
  type        = string
  description = "wildcard certificate arn"
}

/*
 * HOSTED ZONE ID
 * Used: route53.tf:16
 */
variable "route53_zone_id" {
  type        = string
  description = "route53 zone id"
}

/*
 * HOSTED ZONE ID
 * Used: route53.tf:16
 */
variable "route53_dns_record_name" {
  type        = string
  description = "domain name (e.g. hello.graylog.com)"
}

/*
 * PUBLIC SUBNET CIDR BLOCKS
 * Used: vpc.tf:32
 */
variable "public_subnets" {
  type        = list(string)
  description = "public subnet cidr blocks"
}

/*
 * PRIVATE SUBNET CIDR BLOCKS
 * Used: vpc.tf:33
 */
variable "private_subnets" {
  type        = list(string)
  description = "private subnet cidr blocks"
}

/*
 * ENVIRONMENT
 * Used: main.tf:37,40
 */
variable "environment" {
  type        = string
  description = "environment name"
}

/*
 * APPLICATION NAME
 * Used: mail.tf:37,41
 */
variable "app_name" {
  type        = string
  description = "application name"
}

/*
 * OWNER
 * Used: main.tf:42
 */
variable "owner" {
  type        = string
  description = "owner"
}

/*
 * INSTANCE TYPE
 * Used: autoscaling-group.tf:18
 */
variable "instance_type" {
  type        = string
  description = "instance type"
}

/*
 * INSTANCE MIN SIZE
 * Used: autoscaling-group.tf:41
 */
variable "instance_min_size" {
  type        = string
  description = "instance type"
}

/*
 * INSTANCE MAX SIZE
 * Used: autoscaling-group.tf:42
 */
variable "instance_max_size" {
  type        = string
  description = "instance type"
}

/*
 * INSTANCE DESIRED CAPACITY
 * Used: autoscaling-group.tf:43
 */
variable "instance_desired_capacity" {
  type        = string
  description = "instance type"
}