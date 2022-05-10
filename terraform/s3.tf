module "s3_bucket" {
  source = "git::ssh://git@github.com/elsevier-centraltechnology/rp-terraform-s3bucket?ref=4.4.0"

  bucket_name          = local.orcid_edm_bucket_name
  s3_bucket_versioning = local.orcid_edm_bucket_versioning_enabled
  tag_contact          = module.globals.contact
  tag_cost_code        = module.globals.cost_code
  tag_description      = "Bucket for transformed orcid edm data"
  tag_environment      = module.globals.environment
  tag_orchestration    = local.common_tags["Orchestration"]
  tag_product          = module.globals.product
  tag_sub_product      = module.globals.sub_product
}

// ADD IN K8s SERVICE ACCOUNT LATER

resource "aws_s3_bucket_policy" "orcid_edm_data_bucket_policy" {
  bucket = module.s3_bucket.s3_bucket_name
  policy = file("configuration/dataconfidential-nonprod-policy.json")
}
