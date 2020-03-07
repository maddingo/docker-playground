provider "kubernetes" {
  host = data.aws_eks_cluster.plantuml.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.plantuml.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.plantuml.token
  load_config_file       = false
}

resource "kubernetes_namespace" "plantuml" {
  metadata {
    name = "plantuml"
  }
}
