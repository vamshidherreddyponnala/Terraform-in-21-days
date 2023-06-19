terraform {
  backend "s3" {
    bucket = "terraform-remote-256"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}


