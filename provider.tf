terraform {
  backend "s3" {
    bucket = "terraform-remote-256"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-remote-2"
  }
}

provider "aws" {
  region = "us-east-1"
}


