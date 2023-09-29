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
    "subnet-00d35da20b86a8711", # us-west-2c
    "subnet-0ee7a2ffc3673b043", # us-west-2a
    "subnet-01fb3c8936fbbcadd", # us-west-2b
  ]
}
