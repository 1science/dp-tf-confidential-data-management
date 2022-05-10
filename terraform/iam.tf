module "service-account-role" {
  source           = "git::ssh://git@github.com/elsevier-centraltechnology/core-terraform-eks.git//eks-iam-role?ref=5.6.2" //Tag for TF 12 version compatibility
  cluster_name     = data.aws_eks_cluster.cluster.name
  role_name        = "dp-orcid-transformer-service-iam-role"
  policies        = ["${data.aws_iam_policy_document.service-account-iam-policy.json}"] 
  service_accounts = ["${local.kubernetes_namespace}/${local.kubernetes_service_account}"]               

  tag_contact          = module.globals.contact
  tag_cost_code        = module.globals.cost_code
  tag_description      = "IAM role for use with orcid transformer service role"
  tag_environment      = module.globals.environment
  tag_orchestration    = local.common_tags["Orchestration"]
  tag_product          = module.globals.product
  tag_sub_product      = module.globals.sub_product
}

data "aws_iam_policy_document" "service-account-iam-policy" {
  statement {
    actions = [
      "s3:*"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}