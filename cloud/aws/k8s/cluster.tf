provider "aws" {
  region = "eu-central-1"
  version = "~> 2.7"
}


data "aws_eks_cluster_auth" "plantuml" {
  name = aws_eks_cluster.plantuml.name
}
