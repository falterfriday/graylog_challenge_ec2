/********************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform Autoscaling Group
 *
 * Location: infra/autoscaling-group.tf
 *
 * Description:
 *  - Provisions sutoscaling group and launch templates
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ********************************************************/

# LAUNCH CONFIGURATION
resource "aws_launch_configuration" "lc_graylog" {
  name_prefix                 = local.name
  image_id                    = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  user_data                   = file("templates/userdata.sh")
  iam_instance_profile        = aws_iam_instance_profile.instance_profile_graylog.name
  key_name                    = aws_key_pair.kp_public_graylog.key_name
  associate_public_ip_address = false

  security_groups = [
    aws_security_group.private_ag_graylog.id,
    aws_security_group.instance_sg_graylog.id
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# AUTOSCALING GROUP
resource "aws_autoscaling_group" "asg_graylog" {
  depends_on = [aws_launch_configuration.lc_graylog]

  name                 = "asg-${local.name}"
  launch_configuration = aws_launch_configuration.lc_graylog.name

  min_size         = var.instance_min_size
  max_size         = var.instance_max_size
  desired_capacity = var.instance_desired_capacity

  vpc_zone_identifier  = module.aws_vpc.private_subnets
  target_group_arns    = [aws_alb_target_group.tg_graylog.arn]
  termination_policies = ["OldestLaunchConfiguration", "ClosestToNextInstanceHour", "Default"]
  health_check_type    = "ELB"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "asg-instance-${local.name}"
    propagate_at_launch = true
  }
}

