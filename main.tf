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

resource "aws_s3_bucket" "bucket-de-almacenamiento" {
  bucket = "bucket-de-almacenamiento" 
  acl    = "private"
}

# Recursos para EKS (Amazon Elastic Kubernetes Service)
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.my_eks_cluster_role.arn
  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

# Rol IAM
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
}

resource "aws_iam_policy_attachment" "eks_cluster_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_policy_attachment" "eks_service_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Nodos de trabajo
resource "aws_launch_configuration" "eks_workers" {
  name_prefix   = "eks-workers-"
  image_id      = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.eks_worker_sg.id]
}

resource "aws_autoscaling_group" "eks_workers" {
  name                  = "eks-workers"
  min_size              = 1
  desired_capacity      = 1
  max_size              = 10
  launch_configuration  = aws_launch_configuration.eks_workers.name
  vpc_zone_identifier   = var.subnet_ids
}
