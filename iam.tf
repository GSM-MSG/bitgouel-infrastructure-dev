resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_iam_role" "ssm_role" {
  name = "ssm-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  inline_policy {
    name = "ssm-access-policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Action = "ssm:StartSession",
        Effect = "Allow",
        Resource = "*"
      }]
    })
  }
}

output "ssm_instance_profile" {
    value = aws_iam_instance_profile.ssm_instance_profile.name
}