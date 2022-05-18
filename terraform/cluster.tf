resource "aws_eks_cluster" "dataplatform-dev" {
  provider                  = aws.cluster
  name                      = "dataplatform-dev"
  role_arn                  = "arn:aws:iam::296075517832:role/dataplatform-dev-cluster-role"
  enabled_cluster_log_types = ["audit", "authenticator"]
  vpc_config {
    subnet_ids = [
      "subnet-03e3813b6dc21c306",
      "subnet-065550fef5852a705",
      "subnet-0b6d2af554f8ea5c3",
      "subnet-0bae27380e5d20104",
      "subnet-0ddd752cd9d0a9ac4",
      "subnet-0def5ad5245f69fed"
    ]
    security_group_ids = [
      "sg-0c2dcd206bbd806d4"
    ]
    endpoint_private_access = true
    endpoint_public_access  = false
  }
  tags_all = {
    "ClusterName"                            = "dataplatform-dev"
    "Contact"                                = "aws-rt-data-platform-nonprod@ets-cloud.com"
    "CostCode"                               = "20882"
    "Description"                            = "eks"
    "Environment"                            = "dev"
    "Name"                                   = "dataplatform.dev.dataplatform-dev"
    "Orchestration"                          = "https://github.com/elsevier-research/dp-core-infra"
    "Product"                                = "dataplatform"
    "SubProduct"                             = "null"
    "kubernetes.io/cluster/dataplatform-dev" = "owned"
    "tio:ModuleVersion"                      = "core-terraform-eks:7.7.0"
  }
}

data "aws_eks_cluster" "dataplatform_dev" {
  name     = "dataplatform-dev"
  provider = aws.cluster
}

data "aws_eks_cluster_auth" "dataplatform_dev" {
  name     = "dataplatform-dev"
  provider = aws.cluster
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.dataplatform_dev.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.dataplatform_dev.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.dataplatform_dev.token
  load_config_file       = false
}
/*
resource "kubernetes_service_account" "orcid_transformer" {

  metadata {
    name = "dp-orcid-transformer-service"
  }
  secret {
    name = "${kubernetes_secret.orcid_transformer.metadata.0.name}"
  }
}

resource "kubernetes_secret" "orcid_transformer" {
  metadata {
    name = "dp-orcid-transformer-service-token-ih9r2"
  }
}*/