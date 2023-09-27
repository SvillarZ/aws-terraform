terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.12.0"
        }
    }
}

provider "aws" {
    region = var.region
}

resource "aws_instance" "ec2_example" {
    ami             = var.ami
    instance_type   = var.instance_type
    tags = {
        Name = var.instance_name
    }
}