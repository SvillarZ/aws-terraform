variable "region" {
    type = string
    default = "us-west-2"
}

variable "ami" {
    type = string
    default = "ami-0f3769c8d8429942f"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "instance_name" {
    type = string
    default = "ec2_example"
}
variable "subnet_ids" {
  type    = list(string)
  default = [
    "subnet-00d35da20b86a8711",
    "subnet-0e97704934613694d",
    "subnet-041b18b73de86caa4",
    "subnet-0bb05d8fdcc20a8ec",
    "subnet-03157af926d4a8bf2",
    "subnet-0ee7a2ffc3673b043",
    "subnet-01fb3c8936fbbcadd",
    "subnet-0726a7516752ac87a",
  ]
}
