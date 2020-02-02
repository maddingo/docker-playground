output "endpoint" {
  value = "${aws_eks_cluster.plantuml.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.plantuml.certificate_authority.0.data}"
}
