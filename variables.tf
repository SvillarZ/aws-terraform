variable "region" {
  type    = string
  default = "us-west-2"
}

variable "ami" {
  type    = string
  default = "ami-0f3769c8d8429942f"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "instance_name" {
  type    = string
  default = "ec2_example"
}

variable "key_pair" {
    description = "Key pair RSA EC2 "
    type = string
    default = "key_pair"
}