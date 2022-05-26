
resource "aws_iam_role" "data_force_control_role" {
  count = var.config["environment"] == "dev" ? 1 : 0

  provider = aws.bucket
  name     = "rdp-data-force-control-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::296075517832:user/data-force",
            "arn:aws:iam::296075517832:role/ADFS-Developer"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "data_force_control_role_policy" {
  count       = var.config["environment"] == "dev" ? 1 : 0

  provider    = aws.bucket
  name        = "rdp-data-force-control-policy"
  description = "Temporary policy for allowing data force to access their data. This should be deleted when automated access is completed"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowUserToSeeBucketListInTheConsole",
        "Action" : [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:s3:::*"
        ]
      },
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1"
        ],
        "Condition" : {
          "StringLike" : {
            "s3:prefix" : [
              "",
              "dp-patent/*",
              "dp-patent",
              "dp-orcid/*",
              "dp-orcid",
              "dp-patent-edm",
              "dp-patent-edm/*",
              "dp-orcid-edm",
              "dp-orcid-edm/*"
            ]
          }
        }
      },
      {
        "Sid" : "applicationdatalistbucket",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-applicationdata-nonprod-useast2-1",
          "arn:aws:s3:::com-elsevier-rdp-applicationdata-prod-useast2-1"
        ],
        "Condition" : {
          "StringLike" : {
            "s3:prefix" : [
              "",
              "dp-patent-harvester-reader/*",
              "dp-patent-harvester-reader"
            ]
          }
        }
      },
      {
        "Sid" : "applicationdata",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucketMultipartUploads",
          "s3:AbortMultipartUpload",
          "s3:DeleteObject",
          "s3:GetBucketLocation",
          "s3:PutObjectAcl",
          "s3:ListMultipartUploadParts"
        ],
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-applicationdata-nonprod-useast2-1/dp-patent-harvester-reader/*",
          "arn:aws:s3:::com-elsevier-rdp-applicationdata-prod-useast2-1/dp-patent-harvester-reader/*"
        ]
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucketMultipartUploads",
          "s3:AbortMultipartUpload",
          "s3:DeleteObject",
          "s3:GetBucketLocation",
          "s3:PutObjectAcl",
          "s3:ListMultipartUploadParts"
        ],
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-orcid",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-orcid/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-orcid",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-orcid/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-orcid-edm",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-orcid-edm/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-orcid-edm",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-orcid-edm/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent-edm",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent-edm/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent-edm",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent-edm/*"
        ]
      },
      {
        "Sid" : "AllowNonDPBucektAccess",
        "Effect" : "Allow",
        "Action" : "s3:*",
        "Resource" : [
          "arn:aws:s3:::dp-patent",
          "arn:aws:s3:::dp-patent/*",
          "arn:aws:s3:::patent-zip-xml/*",
          "arn:aws:s3:::patent-zip-xml"
        ]
      }
    ]
  })
}