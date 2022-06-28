
resource "aws_iam_role" "dp_access_transformer" {
  provider = aws.bucket
  name     = "dp-access-transformer-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_access_read_write_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

output "dp_access_transformer_arn" {
  value = aws_iam_role.dp_access_transformer.arn
}