/******************************************************
 * 
 * GRAYLOG CHALLENGE - Terraform IAM 
 *
 * Location: infra/iam.tf
 *
 * Description:
 *  - Provisions IAM Roles, Policies, and Profiles
 * 
 * Author: Patrick Todd <patrick.a.todd@gmail.com>
 *
 ******************************************************/

# IAM INSTANCE PROFILE
resource "aws_iam_instance_profile" "instance_profile_graylog" {
  name = "instance-profile-${local.name}"
  role = aws_iam_role.instance_role_graylog.name
  tags = merge(local.tags, tomap({ Name = "instance-profile-${local.name}" }))
}

# ASSUME ROLE POLICY
resource "aws_iam_role" "instance_role_graylog" {
  name               = "instance-role-${local.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_graylog.json
  tags               = merge(local.tags, tomap({ Name = "instance-role-${local.name}" }))
}

# SSM
resource "aws_iam_role_policy_attachment" "iam_role_policy_attch_ssm_policy" {
  role       = aws_iam_role.instance_role_graylog.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "iam_instance_policy_graylog" {
  name   = "iam-policy-describe-${local.name}"
  role   = aws_iam_role.instance_role_graylog.id
  policy = data.aws_iam_policy_document.instance_policy_graylog.json
}