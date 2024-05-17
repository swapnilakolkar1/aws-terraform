terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = ">= 5.49.0"
    }
  }
}
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\swapnilAk\\.aws\\credentials"]
  shared_config_files      = ["C:\\Users\\swapnilAk\\.aws\\config"]
}

