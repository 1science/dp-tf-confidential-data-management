
resource "aws_iam_role" "dp_access_readwrite" {
  provider = aws.bucket
  name     = "dp-access-readwrite-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::296075517832:role/dataplatform-${var.config.environment}-dp-orcid-transformer-service-iam-role",
            "arn:aws:iam::296075517832:role/ADFS-Developer"
          ]
        },
        "Action" : "sts:AssumeRole"
      },
    ]
  })
}

output "dp_access_readwrite_arn" {
  value = aws_iam_role.dp_access_readwrite.arn
}