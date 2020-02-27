provider "aws" {
  region = "eu-central-1"
  version = "~> 2.7"
}

data "aws_route53_zone" "public" {
  name         = "${var.domain_name}."
  private_zone = false
}

resource "aws_route53_record" "plantuml" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = "plantuml"
  type    = "CNAME"

  records = [kubernetes_service.plantuml.external_name]
}
