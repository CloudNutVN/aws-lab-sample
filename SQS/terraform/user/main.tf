locals {
  policy_json = jsondecode(file("${path.module}/policy.json"))
}

provider "aws" {
  region = var.region
}

resource "aws_iam_user" "iam_user" {
  name = var.user_name
}

resource "aws_iam_policy" "iam_policy" {
  name   = "${var.user_name}_policy"
  policy = jsonencode(local.policy_json)
}

resource "aws_iam_user_policy_attachment" "example" {
  user       = aws_iam_user.iam_user.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_user_login_profile" "iam_login_profile" {
  user                    = aws_iam_user.iam_user.name
  password_length = 10
}

resource "aws_iam_access_key" "iam_access_key" {
  user = aws_iam_user.iam_user.name
}



