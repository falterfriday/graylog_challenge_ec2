/******************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform App Load Balancer
 *
 * Location: env/.tfvars
 *
 * Description:
 *  - Provisions application load balancer
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ******************************************************/

# APPLICATION LOAD BALANCER
resource "aws_alb" "alb_graylog" {
  name               = "alb-${local.name}"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.private_ag_graylog.id, aws_security_group.alb_sg_graylog.id]
  subnets         = module.aws_vpc.public_subnets

  enable_deletion_protection = false

  tags = merge(local.tags, { Name = "alb-${local.name}" })
}

# ALB LISTENER - HTTP - PORT 8080
resource "aws_alb_listener" "alb_listener_http_graylog" {
  load_balancer_arn = aws_alb.alb_graylog.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.tg_graylog.arn
    type             = "forward"
  }
}

# ALB TARGET GROUP - PORT 8080
resource "aws_alb_target_group" "tg_graylog" {
  name     = "tg-${local.name}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.aws_vpc.vpc_id

  health_check {
    path                = "/"
    port                = 8080
    healthy_threshold   = 10
    unhealthy_threshold = 10
    timeout             = 120
    interval            = 300
    matcher             = "200"
  }
}