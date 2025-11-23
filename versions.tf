terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0" 
    }
  }

  backend "s3" {
    bucket         = "constellation-tf-state-294933866854" 
    key            = "main/terraform.tfstate"
    region         = "ap-northeast-1" 
    use_lockfile   = true 
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-1" 
}