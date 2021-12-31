terraform {
  backend "s3" {
    bucket         = "terrafacer"
    key            = "non-prod/family-goals.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform"
    encrypt        = true
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

