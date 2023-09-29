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
  default = "t2.micro"
}

variable "instance_name" {
  type    = string
  default = "ec2_example"
}
variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0123456789abcdef0", # us-west-2a
    "subnet-0123456789abcdef1", # us-west-2b
    "subnet-0123456789abcdef2", # us-west-2c
  ]
}
