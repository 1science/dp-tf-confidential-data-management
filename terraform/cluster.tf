resource "aws_eks_cluster" "dataplatform-dev" {
  provider = "aws.us-east-2"
  name     = "dataplatform-dev"
  role_arn = "arn:aws:iam::296075517832:role/dataplatform-dev-cluster-role"
  vpc_config {
    subnet_ids = [
      "subnet-0ddd752cd9d0a9ac4",
      "subnet-0bae27380e5d20104",
      "subnet-03e3813b6dc21c306",
      "subnet-0def5ad5245f69fed",
      "subnet-0b6d2af554f8ea5c3",
      "subnet-065550fef5852a70",
    ]
  }
}