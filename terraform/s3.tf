
resource "aws_s3_bucket" "dataconfidential" {
  bucket   = "com-elsevier-rdp-dataconfidential-nonprod-useast2-1"
  provider = aws.us-east-2

  tags = {
    Name        = "dataconfidential"
    Environment = "nonprod"
  }
}

resource "aws_s3_bucket_policy" "dataconfidential_policy" {
  bucket = "com-elsevier-rdp-dataconfidential-nonprod-useast2-1"
  policy = file("configurations/dataconfidential-nonprod-policy.json")
}

resource "aws_s3_bucket_acl" "dataconfidential_acl" {
  bucket = aws_s3_bucket.dataconfidential.id
  acl    = "private"
}