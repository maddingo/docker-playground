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

resource "kubernetes_deployment" "plantuml" {
  metadata {
    name = "plantuml"
    labels = {
      app = "plantuml"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "plantuml"
      }
    }

    template {
      metadata {
        labels = {
          app = "plantuml"
        }
      }

      spec {
        container {
          image = "plantuml/plantuml-server:tomcat"
          name  = "plantuml"
          ports = {
            container_port = 8080
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 8080

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "plantuml" {
  metadata {
    name = "plantuml"
  }
  spec {
    selector = {
      app = kubernetes_deployment.plantuml.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress" "plantuml" {
  metadata {
    name = "plantuml"
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = "plantuml"
            service_port = 80
          }

          path = ["/uml/*", "/svg/*"]
        }
      }
    }

    tls {
      secret_name = "tls-secret"
    }
  }
}
