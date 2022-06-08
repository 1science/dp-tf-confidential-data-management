
resource "aws_iam_role" "dp_access_readwrite" {
  provider = aws.bucket
  name     = "dp-access-readwrite-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow"
        "Principal": { "AWS": var.config["dp_access_read_write_arn"] }
        "Action": "sts:AssumeRole"
        "Condition": {}
      }
    ]
  })
}

output "dp_access_readwrite_arn" {
  value = aws_iam_role.dp_access_readwrite.arn
}