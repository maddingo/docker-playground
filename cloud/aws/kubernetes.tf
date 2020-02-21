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
          image = "maddingo/plantuml-server"
          name  = "plantuml"

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
              path = "/plantuml"
              port = 8080
            }

            initial_delay_seconds = 10
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
      app = "plantuml"
    }
    #session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 8080
      protocol = "TCP"
    }

    type = "NodePort"
  }
}

resource "kubernetes_ingress" "plantuml" {
  metadata {
    name = "plantuml"
    annotations = {
      "kubernetes.io/ingress.class" = "alb"
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      "alb.ingress.kubernetes.io/listen-ports" =  [{"HTTP": 80}, {"HTTPS":443}]
      "alb.ingress.kubernetes.io/group" = "plantuml"
      "alb.ingress.kubernetes.io/certificate-arn" = aws_acm_certificate.cert.arn
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = "plantuml"
            service_port = 80
          }

          path = "/plantuml/*"
        }
      }
    }
  }
}
