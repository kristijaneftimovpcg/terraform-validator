terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.6"
    }
  }

  backend "s3" {
    bucket  = "terraform-validator-bucket"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    # profile = "playground"
  }

  required_version = "~> 1.6"
}

provider "aws" {
  region  = "eu-west-1"
  # profile = "playground"
}