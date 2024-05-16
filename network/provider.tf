terraform {
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


