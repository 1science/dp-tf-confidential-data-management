
#============================ ROLES FOR ORCID HARVESTER ============================#

resource "aws_iam_role" "dp_access_orcid_transformer" {
  provider = aws.bucket
  name     = "dp-access-transformer-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_orcid_transformer_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_orcid_writer" {
  provider = aws.bucket
  name     = "dp-access-writer-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_orcid_writer_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_orcid_writer_test" {  # only exists in non-prod AWS account
  provider = aws.bucket
  name     = "dp-access-writer-3"
  count    = var.config["environment"] == "dev" ? 1 : 0  # equivalent to enabled/disabled
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_orcid_writer_service_test_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_orcid_reader" {
  provider = aws.bucket
  name     = "dp-access-reader-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_orcid_reader_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_orcid_reader_test" {  # only exists in non-prod AWS account
  provider = aws.bucket
  name     = "dp-access-reader-3"
  count    = var.config["environment"] == "dev" ? 1 : 0  # equivalent to enabled/disabled
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_orcid_reader_service_test_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}


output "dp_access_orcid_transformer_arn" {
  value = aws_iam_role.dp_access_orcid_transformer.arn
}

output "dp_access_orcid_writer_arn" {
  value = aws_iam_role.dp_access_orcid_writer.arn
}

output "dp_access_orcid_writer_test_arn" {
  value = aws_iam_role.dp_access_orcid_writer_test.*.arn
}

output "dp_access_orcid_reader_arn" {
  value = aws_iam_role.dp_access_orcid_reader.arn
}

output "dp_access_orcid_reader_test_arn" {
  value = aws_iam_role.dp_access_orcid_reader_test.*.arn
}


#============================ ROLES FOR PATENT HARVESTER ============================#


resource "aws_iam_role" "dp_access_patent_transformer" {
  provider = aws.bucket
  name     = "dp-access-transformer-2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_patent_transformer_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_patent_transformer_test_env" {
  count    = var.config["environment"] == "dev" ? 1 : 0
  provider = aws.bucket
  name     = "dp-access-transformer-3"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_test_patent_transformer_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_patent_writer" {
  provider = aws.bucket
  name     = "dp-access-writer-2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_patent_writer_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_patent_reader" {
  provider = aws.bucket
  name     = "dp-access-reader-2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_patent_reader_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_patent_reference_translator" {
  provider = aws.bucket
  name     = "dp-access-translator-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_patent_reference_translator_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_patent_reference_translator_test_env" {
  count    = var.config["environment"] == "dev" ? 1 : 0
  provider = aws.bucket
  name     = "dp-access-translator-test"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_patent_reference_translator_service_role_test_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_patent_reference_tagger" {
  provider = aws.bucket
  name     = "dp-access-tagger-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_patent_reference_tagger_service_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_patent_reference_tagger_test_env" {
  count    = var.config["environment"] == "dev" ? 1 : 0
  provider = aws.bucket
  name     = "dp-access-tagger-test"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_patent_reference_tagger_service_role_test_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}



output "dp_access_patent_transformer_arn" {
  value = aws_iam_role.dp_access_patent_transformer.arn
}

output "dp_access_patent_writer_arn" {
  value = aws_iam_role.dp_access_patent_writer.arn
}

output "dp_access_patent_reader_arn" {
  value = aws_iam_role.dp_access_patent_reader.arn
}

output "dp_access_patent_reference_translator_arn" {
  value = aws_iam_role.dp_access_patent_reference_translator.arn
}

#============================ ROLES FOR ADAPTOR FILTER ============================#

resource "aws_iam_role" "dp_access_adaptor_filter" {
  provider = aws.bucket
  name     = "dp-access-filter-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_works_service_adaptor_filter_role_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_adaptor_filter_test_env" {
  count    = var.config["environment"] == "dev" ? 1 : 0
  provider = aws.bucket
  name     = "dp-access-filter-test"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_works_service_adaptor_filter_role_test_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_role" "dp_access_adaptor_filter_uat_env" {
  count    = var.config["environment"] == "dev" ? 1 : 0
  provider = aws.bucket
  name     = "dp-access-filter-uat"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow"
        "Principal" : { "AWS" : var.config["dp_works_service_adaptor_filter_role_uat_arn"] }
        "Action" : "sts:AssumeRole"
        "Condition" : {}
      }
    ]
  })
}

