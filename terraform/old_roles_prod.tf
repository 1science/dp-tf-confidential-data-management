
resource "aws_iam_role" "edm_access_prod_role" {
  count       = var.config["environment"] == "dev" ? 0 : 1
  description = "A role for accessing production EDM data from services for the Person Registry"
  tags = {
    "contact" = "datacastor@elsevier.com"
  }
  provider = aws.bucket
  name     = "dp-edm-access-prod"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::023759106857:root"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "exporter_iamrole_dataconfidential" {
  count = var.config["environment"] == "dev" ? 0 : 1
  tags = {
    "Contact"           = "aaws-rt-dataconfidential-prod@ets-cloud.com"
    "CostCode"          = "20882"
    "Description"       = "dataset_publisher"
    "Environment"       = "prod"
    "Name"              = "bos-exporter-iamrole-dataconfidential"
    "Orchestration"     = "https://github.com/elsevier-research/dp-dataconfidential-infra"
    "Product"           = "dataconfidential"
    "SubProduct"        = ""
    "bos:ModuleVersion" = "bos-metadata-exporter:3.0.0"
  }
  provider = aws.bucket
  name     = "bos-exporter-iamrole-dataconfidential"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  inline_policy {
    name = "bos-exporter-dataconfidential"
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject",
            "s3:GetBucketLocation"
          ],
          "Resource" : [
            "arn:aws:s3:::*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "sqs:*"
          ],
          "Resource" : [
            "arn:aws:sqs:us-east-2:831790613400:metadataexporter-dataconfidential"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:*:*:*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:*"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:*",
            "kms:Decrypt"
          ],
          "Resource" : "*"
        }
      ]
    })
  }
}

resource "aws_iam_role" "cat_control_role" {
  count       = var.config["environment"] == "dev" ? 0 : 1
  description = "Allows S3 to call AWS services on your behalf."
  provider    = aws.bucket
  name        = "rdp-cat-control-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "s3.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::501843211453:role/dp-cat-role"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role" "sccontent_dp_patent_prod" {
  count = var.config["environment"] == "dev" ? 0 : 1

  provider = aws.bucket
  name     = "sccontent-dp-patent-prod"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::814132467461:role/patent_transformer-iamrole-prod"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "univentio_patents_data_load_1" {
  count = var.config["environment"] == "dev" ? 0 : 1

  provider = aws.bucket
  path     = "/service-role/"
  name     = "SnowFamilyS3Import-Univentio-patents-data-load-1"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "importexport.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}
