
resource "aws_iam_role" "dp_orcid_transformer_service_dev" {
  count = var.config["environment"] == "dev" ? 1 : 0
  provider = aws.cluster

  name = "dataplatform-dev-dp-orcid-transformer-service-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated": "arn:aws:iam::296075517832:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/9C5B7CF64AF6BA81569C6B5BDD8C0A18"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "ForAnyValue:StringLike": {
            "oidc.eks.us-east-2.amazonaws.com/id/9C5B7CF64AF6BA81569C6B5BDD8C0A18:sub": "system:serviceaccount:person-transformation:dp-orcid-transformer-service"
          }
        }
      },
    ]
  })
  tags = {
    Contact:	"DataPlatform@ReedElsevier.com"
    CostCode:	"20882"
    Description:	"IAM role for use with orcid transformer service role"
    Environment:	"dev"
    Name:	"dataplatform-dev-dp-orcid-transformer-service-iam-role"
    Orchestration:	"https://github.com/elsevier-research/dp-orcid-transformer-service"
    Product:	"dataplatform"
    SubProduct:	"null"
    "kubernetes.io/cluster/dataplatform-dev":	"owned"
    "kubernetes.io/cluster/dataplatform-dev/role":	"enabled"
    "tio:ModuleVersion":	"core-terraform-eks:5.6.2"
  }
}

resource "aws_iam_role" "dp_access_readwrite" {
  provider = aws.bucket
  name     = "dp-access-readwrite-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : var.config["dp_access_read_write_arn"]
        },
        "Action" : "sts:AssumeRole"
      },
    ]
  })
}

output "dp_access_readwrite_arn" {
  value = aws_iam_role.dp_access_readwrite.arn
}