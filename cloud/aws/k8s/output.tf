output "plantuml_address" {
  value = "https://${aws_route53_record.plantuml.fqdn}"
}

output "plantuml_lb_address" {
  value = kubernetes_service.plantuml.load_balancer_ingress.0.hostname
}

output "echo_lb_address" {
  value = kubernetes_service.echo.load_balancer_ingress.0.hostname
}
