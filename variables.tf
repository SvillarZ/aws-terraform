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

# variable "key_pair" {
#     type = string
#     default = "key-test"
# }

# variable "security_groups" {
#     type = list(string)
#     default = [ "launch-wizard-1" ]
# }

variable "instance_name" {
    type = string
    default = "ec2_example"
}