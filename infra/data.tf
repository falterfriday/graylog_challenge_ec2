/******************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform Variables
 *
 * Location: env/.tfvars
 *
 * Description:
 *  - Variables passed to Terraform 
 *  - If variable does not have a `default` argument, it
 *    will be located in the env/.tfvars file
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 * Listening To:
 *  - Deadmau5: For Lack of a Better Name
 *
 ******************************************************/

data "aws_region" "current" {}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

data "aws_iam_policy_document" "assume_role_policy_graylog" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "instance_policy_graylog" {
  statement {
    actions = [
      "autoscaling:*",
      "ec2:*",
      "ecr:*",
      "elasticloadbalancing:*",
      "logs:*",
      "ssm:*",
      "sts:AssumeRole",
      "tag:*",
    ]

    resources = ["*"]
    sid       = ""
    effect    = "Allow"
  }
}