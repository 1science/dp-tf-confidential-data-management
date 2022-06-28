
resource "aws_iam_role" "edm_access_nonprod_role" {
  count = var.config["environment"] == "dev" ? 1 : 0

  provider = aws.bucket
  name     = "dp-edm-access-nonprod"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::296075517832:root"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
  })
}

resource "aws_iam_policy" "edm_access_nonprod_role_policy" {
  count = var.config["environment"] == "dev" ? 1 : 0

  name        = "dp-edm-access"
  description = "Person Registry policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
        "Condition": {
          "StringEquals": {
            "s3:prefix": [
              "",
              "dp-patent-edm",
              "dp-patent-edm/",
              "dp-orcid-edm",
              "dp-orcid-edm/"
            ]
          }
        }
      },
      {
        "Sid": "",
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
        "Condition": {
          "StringLike": {
            "s3:prefix": [
              "dp-patent-edm/*",
              "dp-orcid-edm/*"
            ]
          }
        }
      },
      {
        "Sid": "",
        "Effect": "Allow",
        "Action": "s3:GetBucketLocation",
        "Resource": "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1"
      },
      {
        "Sid": "",
        "Effect": "Allow",
        "Action": "s3:GetObject",
        "Resource": [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent-edm/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-orcid-edm/*"
        ]
      }
    ]
  })
}