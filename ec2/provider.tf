terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = ">= 5.49.0"
    }
  }
}
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAZI2LCA37OCQAXA5F"
  secret_key = "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"
}


