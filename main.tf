terraform {
  required_version = "~> 0.12.19"
}

provider "aws" {
  region  = var.aws_region
  version = "~> 2.48"
}