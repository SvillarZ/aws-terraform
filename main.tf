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
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}

# resource "aws_s3_bucket" "bucket-de-almacenamiento" {
#   bucket = "bucket-de-almacenamiento" 
#   acl    = "private"
# }

# resource "aws_s3_bucket_acl" "bucket-de-almacenamiento-acl" {
#   bucket = aws_s3_bucket_acl.bucket-de-almacenamiento-acl.id

#   # Reglas ACL públicas para lectura
#   permissions = ["READ"]

#   grants {
#     type        = "Group"
#     uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
#   }
# }

resource "aws_s3_bucket" "mi_bucket" {
  bucket = "bucket-de-almacenamiento"
  acl    = "private"
}

resource "aws_s3_bucket_policy" "mi_bucket_policy" {
  bucket = aws_s3_bucket.mi_bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::bucket-de-almacenamiento/*",
      "Condition": {
        "StringEquals": {
          "aws:SourceVpc": "${aws_vpc.my_vpc.id}"
        }
      }
    }
  ]
}
EOF
}

# Recursos para EKS (Amazon Elastic Kubernetes Service)
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.my-eks_cluster_role.arn
  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

# Rol IAM
resource "aws_iam_role" "my-eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "my-eks_cluster_attachment" {
  name       = "my-eks-cluster-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.my-eks_cluster_role.name]
}

resource "aws_iam_policy_attachment" "my-eks_service_attachment" {
  name       = "my-eks-service-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  roles      = [aws_iam_role.my-eks_cluster_role.name]
}
resource "aws_security_group" "eks_worker_sg" {
  name        = "eks-worker-sg"
  description = "Security group for EKS worker nodes"
}

# Nodos de trabajo
resource "aws_launch_configuration" "eks_workers" {
  name_prefix     = "eks-workers-"
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.eks_worker_sg.id]
}

resource "aws_autoscaling_group" "eks_workers" {
  name                 = "eks-workers"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 10
  launch_configuration = aws_launch_configuration.eks_workers.name
  vpc_zone_identifier  = var.subnet_ids
}
