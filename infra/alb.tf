/******************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform App Load Balancer
 *
 * Location: env/.tfvars
 *
 * Description:
 *  - Provisions application load balancer, listener,
 *    and target group
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ******************************************************/

# APPLICATION LOAD BALANCER
resource "aws_alb" "alb_graylog" {
  name               = "alb-${local.name}"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.private_sg_graylog.id, aws_security_group.alb_sg_graylog.id]
  subnets         = module.aws_vpc.public_subnets

  enable_deletion_protection = false

  tags = merge(local.tags, { Name = "alb-${local.name}" })
}

# ALB LISTENER - HTTPS
resource "aws_alb_listener" "alb_listener_https_graylog" {
  depends_on        = [aws_alb_target_group.tg_https_graylog]

  load_balancer_arn = aws_alb.alb_graylog.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
   
  default_action {
    target_group_arn = aws_alb_target_group.tg_https_graylog.arn
    type             = "forward"
  }
}

# ALB TARGET GROUP - PORT 443
resource "aws_alb_target_group" "tg_https_graylog" {
  name     = "tg-https-${local.name}"
  port     = 443
  protocol = "HTTP"
  vpc_id   = module.aws_vpc.vpc_id

  health_check {
    path                = "/"
    port                = 443
    healthy_threshold   = 10
    unhealthy_threshold = 10
    timeout             = 120
    interval            = 300
    matcher             = "200"
  }
}