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


# Recursos para EKS (Amazon Elastic Kubernetes Service)
resource "aws_eks_cluster" "my_cluster" {
    name     = "my-eks-cluster"
    role_arn = aws_iam_role.my_eks_cluster_role.arn
    vpc_config {
        subnet_ids = var.subnet_ids
    }
}

# Recurso para el bucket de S3
resource "aws_s3_bucket" "bucket-de-almacenamiento" {
    bucket = "bucket-de-almacenamiento"
    acl    = "private"
}

# Configuración de Kops (para EKS)
resource "null_resource" "kops" {
        provisioner "local-exec" {
        command = <<EOT
            def clusterName = 'cluster-de-almacenamiento'
            def awsRegion = 'us-west-2'

            kops create cluster --name=${clusterName} --zones=${awsRegion}
            kops update cluster ${clusterName} --yes
EOT
    }
}