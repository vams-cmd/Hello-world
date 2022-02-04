provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "vamsict2"
    key    = "path/to/my/key"
    region = "us-east-1"
	  dynamodb_table = "assignment_two"
  }
}
