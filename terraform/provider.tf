provider "aws" {
  alias                    = "bucket"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dp-bucket"
}

terraform {
  backend "s3" {
  }
}