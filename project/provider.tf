provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "my-aws-bucketner"
    key    = "packer/terraform.tfstate"
    region = "eu-central-1"
  }
}
