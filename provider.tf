terraform {
  backend "s3" {
    bucket = "terraform-remote2789"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-remote"
  }
}

provider "aws" {
  region = "us-east-1"
}


