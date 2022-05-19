
resource "aws_s3_bucket" "dataconfidential" {
  bucket   = var.config["bucket"]
  provider = aws.bucket
  arn      = var.config["bucket_arn"]

  tags = {
    Name        = "dataconfidential"
    Environment = var.config["tag_environment"]
    Product     = "Data Platform"
  }
}

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

resource "aws_iam_role_policy" "dp_access_readwrite_policy" {
  name               = "dp-access-readwrite"
  role               = aws_iam_role.dp_access_readwrite.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Sid      = "AllowReadWriteAccountAccessToData"
        Resource = [var.config["bucket_arn"], format("%s/*", var.config["bucket_arn"])]
      },
    ]
  })
}

output "dp_access_readwrite_arn" {
  value = aws_iam_role.dp_access_readwrite.arn
}

resource "aws_s3_bucket_policy" "dataconfidential_policy" {
  bucket = var.config["bucket"]
  policy = var.config["environment"] == "dev" ? file("configurations/dataconfidential-nonprod-policy.json") : file("configurations/dataconfidential-prod-policy.json")
}

