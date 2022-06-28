
resource "aws_iam_role" "edm_access_prod_role" {
  count = var.config["environment"] == "dev" ? 0 : 1

  provider = aws.bucket
  name     = "dp-edm-access-prod"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::023759106857:root"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
  })
}


resource "aws_iam_policy" "edm_access_prod_role_policy" {
  count = var.config["environment"] == "dev" ? 0 : 1

  name        = "dp-edm-access"
  description = "Person Registry policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1",
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
        "Resource": "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1",
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
        "Resource": "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1"
      },
      {
        "Sid": "",
        "Effect": "Allow",
        "Action": "s3:GetObject",
        "Resource": [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent-edm/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-orcid-edm/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "exporter_iamrole_dataconfidential" {
  count = var.config["environment"] == "dev" ? 0 : 1

  provider = aws.bucket
  name     = "bos-exporter-iamrole-dataconfidential"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "exporter_iamrole_dataconfidential_policy" {
  count = var.config["environment"] == "dev" ? 0 : 1

  name        = "bos-exporter-dataconfidential"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:GetBucketLocation"
        ],
        "Resource": [
          "arn:aws:s3:::*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "sqs:*"
        ],
        "Resource": [
          "arn:aws:sqs:us-east-2:831790613400:metadataexporter-dataconfidential"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:*"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:*",
          "kms:Decrypt"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "cat_control_role" {
  count = var.config["environment"] == "dev" ? 0 : 1

  provider = aws.bucket
  name     = "rdp-cat-control-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "s3.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      },
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::501843211453:role/dp-cat-role"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "cat_control_role_policy" {
  count = var.config["environment"] == "dev" ? 0 : 1

  name        = "rdp-cat-control-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "ListBucketAccess",
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource": [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1"
        ],
        "Condition": {
          "StringLike": {
            "s3:prefix": [
              "dp-patent/*",
              "dp-patent",
              "inventory",
              "inventory/*"
            ]
          }
        }
      },
      {
        "Sid": "ListInventoryBucketAccess",
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource": [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1-inventory"
        ],
        "Condition": {
          "StringLike": {
            "s3:prefix": [
              "dp-patent/*",
              "dp-patent",
              "inventory",
              "inventory/*"
            ]
          }
        }
      },
      {
        "Sid": "ReadAccess",
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:ListBucketMultipartUploads",
          "s3:GetBucketLocation",
          "s3:ListMultipartUploadParts"
        ],
        "Resource": [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1-inventory/dp-patent/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/inventory/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1-inventory",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1-inventory/*"
        ]
      }
    ]
  })
}


resource "aws_iam_role" "sccontent_dp_patent_prod" {
  count = var.config["environment"] == "dev" ? 0 : 1

  provider = aws.bucket
  name     = "sccontent-dp-patent-prod"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::814132467461:role/patent_transformer-iamrole-prod"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
  })
}


resource "aws_iam_policy" "sccontent_dp_patent_prod_policy" {
  count = var.config["environment"] == "dev" ? 0 : 1

  name        = "sccontent-dp-patent"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:List*",
          "s3:Get*",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        "Resource": [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/*",
          "arn:aws:s3:::dp-patent",
          "arn:aws:s3:::dp-patent/*"
        ]
      }
    ]
  })
}


resource "aws_iam_role" "univentio_patents_data_load_1" {
  count = var.config["environment"] == "dev" ? 0 : 1

  provider = aws.bucket
  name     = "SnowFamilyS3Import-Univentio-patents-data-load-1"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "importexport.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "univentio_patents_data_load_1_policy" {
  count = var.config["environment"] == "dev" ? 0 : 1

  name        = "SnowFamilyS3Import-Univentio-patents-data-load-1-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetBucketPolicy",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads",
          "s3:ListBucket",
          "s3:HeadBucket",
          "s3:PutObject",
          "s3:AbortMultipartUpload",
          "s3:ListMultipartUploadParts",
          "s3:PutObjectAcl",
          "s3:GetObject"
        ],
        "Resource": [
          "arn:aws:s3:::dp-patent",
          "arn:aws:s3:::dp-patent/*"
        ]
      }
    ]
  })
}