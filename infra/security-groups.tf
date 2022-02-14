/******************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform Security Groups
 *
 * Location: infra/security-groups.tf
 *
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 * Description:
 *  - Security Group configurations
 *
 ******************************************************/

/*
 * PRIVATE SUBNET INSTANCE SECURITY GROUP
 */
resource "aws_security_group" "private_sg_graylog" {
  name                   = "private-sg-${local.name}"
  description            = "private subnet instance security group"
  vpc_id                 = module.aws_vpc.vpc_id
  revoke_rules_on_delete = true

  tags = merge(local.tags, tomap({ Name = "private-sg-${local.name}" }))
}

# SECURITY GROUP RULE - PRIVATE EGRESS - ALL PORTS
resource "aws_security_group_rule" "sgr_private_egress_graylog" {
  description       = "egress from private - all"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_sg_graylog.id
}

/*
 * APPLICATION LOAD BALANCER SECURITY GROUP
 */
resource "aws_security_group" "alb_sg_graylog" {
  name                   = "alb-sg-${local.name}"
  description            = "alb security group"
  vpc_id                 = module.aws_vpc.vpc_id
  revoke_rules_on_delete = true

  tags = merge(local.tags, tomap({ Name = "alb-sg-${local.name}" }))
}

# SECURITY GROUP RULE - ALB INGRESS - PORT 443
resource "aws_security_group_rule" "alb_sgr_https_graylog" {
  depends_on = [aws_security_group.alb_sg_graylog]

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg_graylog.id
}


/*
 * INSTANCE SECURITY GROUP
 */
resource "aws_security_group" "instance_sg_graylog" {
  name                   = "instance-sg-${local.name}"
  description            = "instance security group"
  vpc_id                 = module.aws_vpc.vpc_id
  revoke_rules_on_delete = true

  tags = merge(local.tags, tomap({ Name = "instance-sg-${local.name}" }))
}

# SECURITY GROUP RULE - INSTANCE INGRESS - PORT 443
resource "aws_security_group_rule" "instance_sgr_ingress_graylog" {
  depends_on = [aws_security_group.instance_sg_graylog]

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [module.aws_vpc.vpc_cidr_block]
  security_group_id = aws_security_group.instance_sg_graylog.id
}