/********************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform Route53 Entries
 *
 * Location: env/.tfvars
 *
 * Description:
 *  - Provision route53 entries
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ********************************************************/


resource "aws_route53_record" "route53_dns_record_graylog" {
  zone_id = var.route53_zone_id
  name    = var.route53_dns_record_name
  type    = "A"

  alias {
    name                   = aws_alb.alb_graylog.dns_name
    zone_id                = aws_alb.alb_graylog.zone_id
    evaluate_target_health = true
  }
}

output "application_url" {
  value = "https://${var.route53_dns_record_name}"
}