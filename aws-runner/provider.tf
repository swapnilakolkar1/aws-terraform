terraform {
  backend "s3" {
    bucket         = "terraform-state-461995"
    key            = "dev/aws-runner/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terrafom-state-lock"
    //  profile        = "terraform"
  }
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = ">= 5.49.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"

}


