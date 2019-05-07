provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["679593333241"]

  filter {
    name = "name"
    values = [
      "Amazon Linux 2*",
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
