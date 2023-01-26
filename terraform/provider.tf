terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"] # TO BE CHANGED | we need to get a credentials file onto the jenkins/user_data on ec2
  region                   = "eu-west-1"
}
