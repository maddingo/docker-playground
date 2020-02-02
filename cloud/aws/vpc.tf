data "aws_vpc" "plantuml" {
    filter {
        name = "tag:Name"
        values = ["Default-VPC"]
    }
}

data "aws_subnet_ids" "plantuml" {
  vpc_id = data.aws_vpc.plantuml.id
}
