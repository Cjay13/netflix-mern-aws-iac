terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
  }

  backend "s3" {
    bucket = "cjay-tf-status"
    key    = "frontend/terraform.tfstate"
    region = "ap-southeast-2"
  }
}