terraform {
  required_version = ">= 0.12.24"
  backend "s3" {}
}

provider "aws" {
  region  = "us-east-2"
  alias = "us-east-2"
}

module "globals" {
  source = "git::ssh://git@github.com/elsevier-research/dp-terraform-config.git?ref=0.0.3"
}

locals {
  kubernetes_namespace                   = "person-transformation"
  kubernetes_service_account             = "dp-orcid-transformer-service"
  orcid_edm_bucket_name      = "dp-orcid-edm-${module.globals.environment}"
  orcid_edm_bucket_versioning_enabled = "false"

  common_tags     = {
    Product       = module.globals.product
    SubProduct    = module.globals.sub_product
    Contact       = module.globals.contact
    CostCode      = module.globals.cost_code
    Environment   = module.globals.environment
    Orchestration = "https://github.com/elsevier-research/dp-orcid-transformer-service"
  }
}

data "aws_eks_cluster" "cluster" {
  name = "dataplatform-${module.globals.environment}"
}
