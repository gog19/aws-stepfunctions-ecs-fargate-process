## SPDX-FileCopyrightText: Copyright 2019 Amazon.com, Inc. or its affiliates
##
### SPDX-License-Identifier: MIT-0

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
    region = "us-east-1"
}