/******************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform Main
 *
 * Location: infra/main.tf
 *
 * Description:
 *  - Starting point for Terraform IaC
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 * Listening To:
 *  - Deadmau5: For Lack of a Better Name
 *
 ******************************************************/

terraform {
  required_version = ">= 1.0.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "local" {
    path = "local_tf_state/terraform-main.tfstate"
  }
}

provider "aws" {
  region = var.region
}

locals {
  name = "${var.environment}-${var.app_name}"

  tags = tomap({
    Environment = "${var.environment}"
    Application = "${var.app_name}"
    Owner       = "${var.owner}"
  })
}