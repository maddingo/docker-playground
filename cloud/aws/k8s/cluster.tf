provider "aws" {
  region = "eu-central-1"
  version = "~> 2.7"
}


data "aws_eks_cluster_auth" "plantuml" {
  name = "plantuml"
}

data "aws_eks_cluster" "plantuml" {
  name = "plantuml"
}

data "aws_acm_certificate" "cert" {
  domain   = "maddin.cloud"
  statuses = ["ISSUED"]
}
