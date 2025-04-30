terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

provider "aws" {
  region = var.region-acm
  alias = "useast1"
}