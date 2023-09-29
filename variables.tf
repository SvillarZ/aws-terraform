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
  default = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}
