provider "aws" {
  region = "eu-central-1"
  version = "~> 2.7"
}

resource "aws_eks_cluster" "plantuml" {
  name     = "plantuml"
  role_arn = aws_iam_role.plantuml.arn

  vpc_config {
    subnet_ids = data.aws_subnet_ids.plantuml.ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.plantuml-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.plantuml-AmazonEKSServicePolicy,
  ]
}

data "aws_eks_cluster_auth" "plantuml" {
  name = aws_eks_cluster.plantuml.name
}

resource "aws_eks_fargate_profile" "plantuml" {
  count = 0 # As of Feb 2. 2020 fargat profiles are not supported in eu-central-1
  cluster_name           = aws_eks_cluster.plantuml.name
  fargate_profile_name   = "plantuml"
  pod_execution_role_arn = aws_iam_role.plantuml.arn
  subnet_ids             = data.aws_subnet_ids.plantuml.ids

  selector {
    namespace = "plantuml"
  }
}

resource "aws_eks_node_group" "plantuml" {
  cluster_name    = aws_eks_cluster.plantuml.name
  node_group_name = "plantuml"
  node_role_arn   = aws_iam_role.plantuml.arn
  subnet_ids      = data.aws_subnet_ids.plantuml.ids

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.plantuml-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.plantuml-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.plantuml-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "maddin.cloud"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
