terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
  backend "s3" {
    bucket  = "yuvaraj-tf-state-bucket"
    key     = "terraform.tfstate"
    region  = "ap-south-1"
    encrypt = false
  }
}

provider "aws" {  
  region     = "ap-south-1"  
}