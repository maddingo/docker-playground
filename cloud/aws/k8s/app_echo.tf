resource "kubernetes_deployment" "echo" {
  metadata {
    name = "echo"
    labels = {
      app = "echo"
    }
    namespace = "plantuml"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "echo"
      }
    }

    template {
      metadata {
        labels = {
          app = "echo"
        }
      }

      spec {
        container {
          image = "containous/whoami"
          name  = "echo"

          resources {
            limits {
              cpu    = "0.1"
              memory = "64Mi"
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

resource "kubernetes_service" "echo" {
  metadata {
    name = "echo"
    namespace = "plantuml"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-ssl-cert": data.aws_acm_certificate.cert.arn
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol": "http"
      "service.beta.kubernetes.io/aws-load-balancer-ssl-ports": "https"
    }
  }

  spec {
    selector = {
      app = "echo"
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
