terraform {
  backend "s3" {
    bucket         = "uat.simple-bank.tf-state"
    key            = "uat.tf-state"
    region         = "eu-west-3"
    encrypt        = true
    dynamodb_table = "uat.simple-bank.tf-state-lock"
  }
}


provider "aws" {
  region = "eu-west-3"
}

