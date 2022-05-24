
resource "aws_iam_role" "dp_access_readwrite" {
  provider = aws.bucket
  name = "dp-access-readwrite-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

output "dp_access_readwrite_arn" {
  value = aws_iam_role.dp_access_readwrite.arn
}