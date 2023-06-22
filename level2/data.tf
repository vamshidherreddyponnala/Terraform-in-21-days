data "terraform_remote_state" "level1" {
    backend = "s3"

    config = {
      bucket  = "terraform-remote2789"
      key     = "L1.tfstate"
      region  = "us-east-1"
    }
}