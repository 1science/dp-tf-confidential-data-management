
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

resource "aws_s3_bucket_policy" "dataconfidential_policy" {
  provider = aws.bucket
  bucket   = var.config["bucket"]
  policy   = var.config["environment"] == "dev" ? file("configurations/dataconfidential-nonprod-policy.json") : file("configurations/dataconfidential-prod-policy.json")
}

