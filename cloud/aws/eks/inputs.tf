variable "domain_name" {
  description = "Route53 domain and hosted zone that should be associated with the VPC"
}

variable "cluster_name" {
  default = "plantuml"
  description = "Cluster name"
}
