
resource "aws_s3_bucket" "dataconfidential" {
  bucket   = "com-elsevier-rdp-dataconfidential-nonprod-useast2-1"
  provider = aws.bucket
  arn = "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1"

  tags = {
    Name        = "dataconfidential"
    Environment = "nonprod"
  }
}

resource "aws_s3_bucket_policy" "dataconfidential_policy" {
  bucket = "com-elsevier-rdp-dataconfidential-nonprod-useast2-1"
  policy = file("configurations/dataconfidential-nonprod-policy.json")
}
