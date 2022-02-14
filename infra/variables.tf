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
 * Used: main.tf:34
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
 */
variable "availability_zones" {
  type        = list(string)
  description = "availability zones"
}

/*
 * PUBLIC SUBNET CIDR BLOCKS
 * Used: vpc.tf:29
 */
variable "public_subnets" {
  type        = list(string)
  description = "public subnet cidr blocks"
}

/*
 * PRIVATE SUBNET CIDR BLOCKS
 * Used: vpc.tf:30
 */
variable "private_subnets" {
  type        = list(string)
  description = "private subnet cidr blocks"
}

/*
 * DATABASE SUBNET CIDR BLOCKS
 * Used: vpc.tf:31
 */
# variable "database_subnets" {
#   type        = list(string)
#   description = "database subnet cidr blocks"
# }

/*
 * ENVIRONMENT
 * Used: vpc.tf:56
 */
variable "environment" {
  type        = string
  description = "environment name"
}

/*
 * APPLICATION NAME
 * Used: vpc.tf:57
 */
variable "app_name" {
  type        = string
  description = "application name"
}

/*
 * OWNER
 * Used: vpc.tf:58
 */
variable "owner" {
  type        = string
  description = "owner"
}


variable "instance_type" {
  type        = string
  description = "instance type"
}

variable "instance_min_size" {
  type        = string
  description = "instance type"
}

variable "instance_max_size" {
  type        = string
  description = "instance type"
}

variable "instance_desired_capacity" {
  type        = string
  description = "instance type"
}