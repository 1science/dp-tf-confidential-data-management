provider "aws" {
  alias                    = "bucket"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dp-bucket2"
}

terraform {
  backend "s3" {
  }
}