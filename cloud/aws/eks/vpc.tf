# data "aws_vpc" "plantuml" {
#     filter {
#         name = "tag:Name"
#         values = ["Default-VPC"]
#     }
# }

resource "aws_vpc" "plantumlcluster" {
  cidr_block = "10.0.0.0/16"
  tags {
      "kubernetes.io/cluster/plantuml": "shared"
  }
}

data "aws_subnet_ids" "plantuml" {
  vpc_id = aws_vpc.plantumlcluster.id
}
