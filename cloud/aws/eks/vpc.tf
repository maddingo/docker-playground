# data "aws_vpc" "plantuml" {
#     filter {
#         name = "tag:Name"
#         values = ["Default-VPC"]
#     }
# }

locals {
  domain_name = var.domain_name
  subnet_ids = [aws_subnet.cluster.*.id]
}

resource "aws_vpc" "cluster" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: "EKS VPC"
    "kubernetes.io/cluster/plantuml": "shared"
  }
}

resource "aws_internet_gateway" "cluster_gw" {
  vpc_id = aws_vpc.cluster.id

  tags = {
    Name = "EKS cluster GW"
  }
}

resource "aws_subnet" "cluster" {
    count = length(data.aws_availability_zones.available.names)
    vpc_id     = aws_vpc.cluster.id
    cidr_block = cidrsubnet(aws_vpc.cluster.cidr_block, 2, count.index )
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
      Name: "Subnet ${data.aws_availability_zones.available.names[count.index]}"
      "kubernetes.io/cluster/plantuml": "shared"
    }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_route" "cluster_igw" {
  route_table_id = aws_vpc.cluster.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.cluster_gw.id
}

resource "aws_route53_zone_association" "cluster_private" {
  zone_id = data.aws_route53_zone.cluster_domain_private.id
  vpc_id = aws_vpc.cluster_vpc.id
}

data "aws_route53_zone" "cluster_domain_private" {
  name = "${var.domain_name}."
  private_zone = true
}

# data "aws_route53_zone" "cluster_domain_public" {
#   name = "${var.domain_name}."
#   private_zone = false
# }
