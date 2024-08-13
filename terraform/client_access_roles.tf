resource "aws_iam_role" "patent_access_engineering_village_role" {
  provider    = aws.bucket
  name        = "dp-patent-access-engineering-village"
  description = "Role for accessing patents from the data confidential bucket."
  tags = {
    "creator"        = "kuyekd"
    "customer"       = "Engineering Village"
    "patent-offices" = "US WO EP GB DE CN JP EN"
  }
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::${var.config["engineering_village_aws_account_id_nonprod"]}:root",
            "arn:aws:iam::${var.config["engineering_village_aws_account_id_prod"]}:root"
          ]
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {}
      }
    ]
  })
  inline_policy {
    name = "patent_access_engineering_village_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = {
        Effect    = "Allow"
        Action   = ["sqs:*"]
        Resource = ["*"]
      }
    })
  }
}

# ---------------------------

resource "aws_iam_role" "sccontent_dp" {
  provider = aws.bucket
  # FIXME: scontent in nonprod and sccontent in prod????
  name                 = var.config["environment"] == "dev" ? "scontent-dp" : "sccontent-dp"
  description          = "Allows EC2 instances to call AWS services on your behalf."
  max_session_duration = 43200
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : var.config["environment"] == "dev" ? "arn:aws:iam::688086236943:role/sccontent-dp-migration-iamrole-cert" : "arn:aws:iam::814132467461:role/sccontent-dp-migration-iamrole-prod"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "sccontent_dp_policy" {
  provider    = aws.bucket
  name        = var.config["environment"] == "dev" ? "sccontent-dp" : "sc-content-to-dp-confidential"
  description = var.config["environment"] == "dev" ? null : "This policy is used to access dp confidential buckets from the sc-content account."
  policy = var.config["environment"] == "dev" ? jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
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
  provider    = aws.bucket
  name        = "dp-patent-access-entellect"
  description = "List/get access to all patent offices for Entellect/RCC"
  tags = {
    "creator"        = "d.kuyek@elsevier.com"
    "customer"       = "entellect"
    "patent-offices" = "all"
  }
  assume_role_policy = var.config["environment"] == "dev" ? jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::290244732740:role/enrichment-services-np-00-docker-entellect-instance-role",
            "arn:aws:iam::290244732740:role/enrichment-services-np-50-docker-entellect-instance-role",
            "arn:aws:iam::290244732740:role/ADFS-EnterpriseAdmin",
            "arn:aws:iam::290244732740:role/enrichment-services-np-01-docker-entellect-instance-role",
            "arn:aws:iam::290244732740:role/ADFS-Developer",
            "arn:aws:iam::290244732740:role/enrichment-services-np-99-docker-entellect-instance-role",
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
    }) : jsonencode({
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

resource "aws_iam_role" "orcid_access_person_registry" {
    provider    = aws.bucket

      assume_role_policy    = jsonencode(
          {
              Statement = [
                  {
                      Action    = "sts:AssumeRole"
                      Effect    = "Allow"
                      Principal = {
                          AWS = [
                            var.config["person_registry_matcher_service_arn"],
                            var.config["person_registry_exhibit_service_arn"]
                          ]
                      }
                  }
              ]
              Version   = "2012-10-17"
            }
      )
      description           = "List/get access to all ORCID content in non-prod"
      force_detach_policies = false
      managed_policy_arns   = []
      max_session_duration  = 3600
      name                  = "dp-orcid-access-pr-${var.config["environment"]}"  # normally name is same in prod and dev, but env dependent here for historical reason
      path                  = "/"
      tags                  = {
          "creator"  = "d.kuyek@elsevier.com"
          "customer" = "Person Registry"
      }
      tags_all              = {
          "creator"  = "d.kuyek@elsevier.com"
          "customer" = "Person Registry"
      }
    }

resource "aws_iam_role" "patent_edm_access_sccontent" {
  provider    = aws.bucket

  name                  = "dp-patent-edm-access-sccontent"
  assume_role_policy    = jsonencode(
    {
      Statement = [
        {
          Action    = "sts:AssumeRole"
          Effect    = "Allow"
          Principal = {
            AWS = var.config["sccontent_patent_edm_arn"]
          }
        }
      ]
      Version   = "2012-10-17"
    }
  )
  description           = "List/get access to all Patent EDM content in non-prod"
  max_session_duration  = 43200
  tags                  = {
    "creator"  = "d.kuyek@elsevier.com"
    "customer" = "SC Content"
  }
}
