provider "aws" {
  alias                    = "bucket"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dp-dev2"
}

terraform {
  backend "s3" {
  }
}