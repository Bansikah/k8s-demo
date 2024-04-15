terraform {
  required_version = ">= 1.1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "vpc" {
  source = "git::https://github.com/gruntwork-io/terraform-fake-modules.git//modules/aws/vpc?ref=main"
}
