resource "kubernetes_deployment" "plantuml" {
  metadata {
    name = "plantuml"
    labels = {
      app = "plantuml"
    }
    namespace = "plantuml"
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
              path = "/"
              port = 80
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
    namespace = "plantuml"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-ssl-cert": data.aws_acm_certificate.cert.arn
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol": "http"
      "service.beta.kubernetes.io/aws-load-balancer-ssl-ports": "https"
    }
  }

  spec {
    selector = {
      app = "plantuml"
    }
    #session_affinity = "ClientIP"
    port {
      name = "https"
      port        = 443
      target_port = 8080
      protocol = "TCP"
    }
    # port {
    #   name = "http"
    #   port        = 80
    #   target_port = 8080
    #   protocol = "TCP"
    # }

    type = "LoadBalancer"
  }
}
