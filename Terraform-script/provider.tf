terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.4"
      }
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "var.region"
}

# Create a VPC
resource "aws_vpc" "capstone-VPC" {
  cidr_block = "10.0.0.0/16"
}