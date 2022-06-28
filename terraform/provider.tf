provider "aws" {
  alias                    = "bucket"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "nonprod"
}

terraform {
  backend "s3" {
  }
}