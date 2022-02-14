/********************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform Keys
 *
 * Location: infra/keys.tf
 *
 * Description:
 *  - Generates SSH key pairs
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ********************************************************/

# KEY PAIR GENERATION
resource "tls_private_key" "kp_private_graylog" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# KEY PAIR
resource "aws_key_pair" "kp_public_graylog" {
  key_name   = "key-pair-${local.name}"
  public_key = tls_private_key.kp_private_graylog.public_key_openssh
  tags       = local.tags
}