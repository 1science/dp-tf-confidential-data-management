provider "aws" {
  alias                    = "bucket"
}

terraform {
  backend "s3" {
  }
}