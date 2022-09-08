terraform {
  backend "s3" {
    bucket         = "prd.simple-bank.tf-state"
    key            = "prd.tf-state"
    region         = "eu-west-3"
    encrypt        = true
    dynamodb_table = "prd.simple-bank.tf-state-lock"
  }
}


provider "aws" {
  region = "eu-west-3"
}

