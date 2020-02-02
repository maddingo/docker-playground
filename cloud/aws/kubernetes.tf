provider "kubernetes" {
  host = aws_eks_cluster.plantuml.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.plantuml.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.plantuml.token

#  cluster_ca_certificate = aws_eks_cluster.plantuml.certificate_authority
}

resource "kubernetes_namespace" "plantuml" {
  metadata {
    name = "plantuml"
  }
}
