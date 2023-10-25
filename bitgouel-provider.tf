terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>4.0"
      }
    }
}


provider "aws" {
    region = "ap-northeast-2"
    access_key = var.bitgouel_access_key
    secret_key = var.gauth_secret_key
}