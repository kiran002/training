#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-958128fa
#
# Your subnet ID is:
#
#     subnet-e34cbc88
#
# Your security group ID is:
#
#     sg-73a74919
#
# Your Identity is:
#
#     terraform-training-catfish
#

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-central-1"
}

variable "count" {
  default = 2
}

terraform {
backend "atlas" {
	name="kiran002/training"
}
}


provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}



resource "aws_instance" "web" {
  count         = "${var.count}"
  ami           = "ami-958128fa"
  instance_type = "t2.micro"
  subnet_id     = "subnet-e34cbc88"

  vpc_security_group_ids = [
    "sg-73a74919",
  ]

  tags {
    "Identity" = "terraform-training-catfish"
    "Owner"    = "bu010"
    "Name"     = "${format("web %d", count.index + 1)}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
