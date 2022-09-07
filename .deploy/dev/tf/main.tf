terraform {
  backend "s3" {
    bucket         = "dev.simple-bank.tf-state"
    key            = "dev.tf-state"
    region         = "eu-west-3"
    encrypt        = true
    dynamodb_table = "dev.simple-bank.tf-state-lock"
  }
}


provider "awssss" {
  region = "eu-west-3"
}

