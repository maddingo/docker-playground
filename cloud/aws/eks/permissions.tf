data "aws_iam_policy_document" "assume_role" {

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com", "eks.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "plantuml" {
  name = "eks-cluster-plantuml"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "plantuml-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.plantuml.name
}

resource "aws_iam_role_policy_attachment" "plantuml-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.plantuml.name
}

resource "aws_iam_role_policy_attachment" "plantuml-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.plantuml.name
}

resource "aws_iam_role_policy_attachment" "plantuml-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.plantuml.name
}

resource "aws_iam_role_policy_attachment" "plantuml-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.plantuml.name
}

resource "aws_iam_role_policy_attachment" "plantuml-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.plantuml.name
}
