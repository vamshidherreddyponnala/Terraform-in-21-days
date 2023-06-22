terraform {
  backend "s3" {
    bucket = "terraform-remote2789"
    key    = "L1.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-remote-state"
  }
}

provider "aws" {
  region = "us-east-1"
}


