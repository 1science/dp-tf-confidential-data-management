
resource "aws_iam_role" "edm_access_nonprod_role" {
  count = var.config["environment"] == "dev" ? 1 : 0

  description = "For accessing EDM data from non-prod DP account for the Person Registry"
  tags = {
    "contact" = "datacastor@elsevier.com"
  }
  provider = aws.bucket
  name     = "dp-edm-access-nonprod"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::296075517832:root"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {}
      }
    ]
  })
}
