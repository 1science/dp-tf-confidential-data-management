provider "aws" {
  region                   = "us-east-2"
  alias                    = "bucket"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dp-dev"
  assume_role {
    session_name = "dp-dev"
    role_arn     = "arn:aws:iam::210275200797:role/ADFS-Developer"
  }
}
