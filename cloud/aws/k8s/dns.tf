data "aws_route53_zone" "public" {
  name         = "${var.domain_name}."
  private_zone = false
}

# resource "aws_route53_record" "plantuml" {
#   zone_id = data.aws_route53_zone.public.zone_id
#   name    = "plantuml"
#   type    = "A"
#   ttl     = 300
#
#   records = [kubernetes_service.plantuml.load_balancer_ip]
# }
