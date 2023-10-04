output "username" {
  value = aws_iam_user.iam_user.name
}

//noinspection HILUnresolvedReference
output "password" {
  value = aws_iam_user_login_profile.iam_login_profile.password
}

output "access_key" {
  value = aws_iam_access_key.iam_access_key.id
}

output "secret_key" {
  value = aws_iam_access_key.iam_access_key.secret
  sensitive = true
}

