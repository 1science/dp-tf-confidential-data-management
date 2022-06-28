
resource "aws_iam_role" "data_force_control_role" {
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
  provider    = aws.bucket
  name        = "rdp-data-force-control-policy"
  description = "Temporary policy for allowing data force to access their data. This should be deleted when automated access is completed"
  policy = var.config["environment"] == "dev" ? jsonencode({
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
    }) : jsonencode({
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
              "dp-orcid-edm/*",
              "com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent",
              "com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/*"
            ]
          }
        }
      },
      {
        "Sid" : "appdata1",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-applicationdata-prod-useast2-1",
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
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent",
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
        "Sid" : "appdata2",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-applicationdata-prod-useast2-1/dp-patent-harvester-reader",
          "arn:aws:s3:::com-elsevier-rdp-applicationdata-prod-useast2-1/dp-patent-harvester-reader/*"
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


resource "aws_iam_role" "patent_access_engineering_village_role" {
  provider = aws.bucket
  name     = "dp-patent-access-engineering-village"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::230521890328:root"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_policy" "patent_access_engineering_village_role_policy" {
  provider = aws.bucket
  name     = "dp-patent-access-engineering-village"
  policy = var.config["environment"] == "dev" ? jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
        "Condition" : {
          "StringEquals" : {
            "s3:prefix" : [
              "",
              "dp-patent",
              "dp-patent/US",
              "dp-patent/EU",
              "dp-patent/WO"
            ]
          }
        }
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
        "Condition" : {
          "StringLike" : {
            "s3:prefix" : [
              "dp-patent/US/*",
              "dp-patent/EU/*",
              "dp-patent/WO/*"
            ]
          }
        }
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "s3:GetBucketLocation",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1"
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent/US/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent/EU/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent/WO/*"
        ]
      }
    ]
    }) : jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1",
        "Condition" : {
          "StringEquals" : {
            "s3:prefix" : [
              "",
              "dp-patent",
              "dp-patent/",
              "dp-patent/US",
              "dp-patent/EP",
              "dp-patent/WO"
            ]
          }
        }
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1",
        "Condition" : {
          "StringLike" : {
            "s3:prefix" : [
              "dp-patent/US/*",
              "dp-patent/EP/*",
              "dp-patent/WO/*"
            ]
          }
        }
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "s3:GetBucketLocation",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1"
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/US/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/EP/*",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/WO/*"
        ]
      }
    ]
  })
}


resource "aws_iam_role" "sccontent_dp" {
  provider = aws.bucket
  name     = "sccontent-dp"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::814132467461:role/sccontent-dp-migration-iamrole-prod"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "sccontent_dp_policy" {
  provider = aws.bucket
  name     = "sc-content-to-dp-confidential"
  policy = var.config["environment"] == "dev" ? jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:List*",
          "s3:Get*",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-orcid/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:List*",
          "s3:Get*"
        ],
        "Resource" : [
          "arn:aws:s3:::sccontent-orcid-xml-cert",
          "arn:aws:s3:::sccontent-orcid-xml-cert/*"
        ]
      }
    ]
    }) : jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:List*",
          "s3:Get*",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        "Resource" : [
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1",
          "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-orcid/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:List*",
          "s3:Get*"
        ],
        "Resource" : [
          "arn:aws:s3:::sccontent-orcid-xml-prod",
          "arn:aws:s3:::sccontent-orcid-xml-prod/*"
        ]
      }
    ]
  })
}


resource "aws_iam_role" "patent_access_entellect" {
  provider = aws.bucket
  name     = "dp-patent-access-entellect"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::511696228681:role/ADFS-Developer",
            "arn:aws:iam::511696228681:role/ADFS-EnterpriseAdmin",
            "arn:aws:iam::511696228681:role/enrichment-services-prod-00-docker-entellect-instance-role",
            "arn:aws:iam::511696228681:role/enrichment-services-prod-01-docker-entellect-instance-role"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "patent_access_all" {
  provider = aws.bucket
  name     = "dp-patent-access-all"
  policy = var.config["environment"] == "dev" ? jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "getbucketlocation",
        "Effect" : "Allow",
        "Action" : "s3:GetBucketLocation",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1"
      },
      {
        "Sid" : "listbucketexact",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
        "Condition" : {
          "StringEquals" : {
            "s3:prefix" : [
              "",
              "dp-patent"
            ]
          }
        }
      },
      {
        "Sid" : "listbucketlike",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1",
        "Condition" : {
          "StringLike" : {
            "s3:prefix" : "dp-patent/*"
          }
        }
      },
      {
        "Sid" : "getobjectlike",
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-nonprod-useast2-1/dp-patent/*"
      }
    ]
    }) : jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "getbucketlocation",
        "Effect" : "Allow",
        "Action" : "s3:GetBucketLocation",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1"
      },
      {
        "Sid" : "listbucketexact",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1",
        "Condition" : {
          "StringEquals" : {
            "s3:prefix" : [
              "",
              "dp-patent"
            ]
          }
        }
      },
      {
        "Sid" : "listbucketlike",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1",
        "Condition" : {
          "StringLike" : {
            "s3:prefix" : "dp-patent/*"
          }
        }
      },
      {
        "Sid" : "getobjectlike",
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::com-elsevier-rdp-dataconfidential-prod-useast2-1/dp-patent/*"
      }
    ]
  })
}
