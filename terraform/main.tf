provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["137112412989"]

  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-2*"
    ]
  }
}

variable "region" {
  description = "The AWS region to deploy to"
  default = ""
}

variable "name" {
  description = "The name of the deployment"
  default = ""
}

variable "public_key" {
  default = ""
}

variable "vpc_id" {
  default = ""
}
