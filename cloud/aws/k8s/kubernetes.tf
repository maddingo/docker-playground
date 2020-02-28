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
          #image = "maddingo/plantuml-server"
          image = "mendhak/http-https-echo"
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
      target_port = 80
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
