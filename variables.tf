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
    "subnet-041b18b73de86caa4",
    "subnet-0ee7a2ffc3673b043",
    "subnet-0726a7516752ac87a"
  ]
}
