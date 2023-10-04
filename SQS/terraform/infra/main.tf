locals {
  policy_json = jsondecode(file("${path.module}/policy.json"))
}

provider "aws" {
  region = var.region
}

resource "aws_iam_policy" "iam_policy" {
  name   = "${var.role_name}_policy"
  policy = jsonencode(local.policy_json)
  tags = {
    "IsLabResources": "true"
  }
}

resource "aws_iam_role" "Lambda_SQS_Role" {
  name = var.role_name
  tags = {
    "IsLabResources": "true"
  }
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"  # Replace with the desired service
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "role_attachment" {
  policy_arn = aws_iam_policy.iam_policy.arn
  role       = aws_iam_role.Lambda_SQS_Role.name
}

