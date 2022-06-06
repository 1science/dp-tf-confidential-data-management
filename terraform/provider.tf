provider "aws" {
  alias                    = "bucket"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dp-bucket"
}

provider "aws" {
  alias                    = "cluster"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dp-cluster"
}

terraform {
  backend "s3" {
  }
}