variable "region" {}

variable "vpc_subnet_cidr_blocks" {
  type = list(string)
}

resource "aws_eks_cluster" "capstone" {
  name = "capstone-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = aws_subnet.private.*.id
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster]
}

resource "aws_iam_role" "eks_cluster" {
  name = "capstone-eks-cluster"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Principal = {
                Service = "eks.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster.name
}

resource "aws_subnet" "private" {
  count = length(var.vpc_subnet_cidr_blocks)

  cidr_block = var.vpc_subnet_cidr_blocks[count.index]
}

output "cluster_endpoint" {
  value = aws_eks_cluster.capstone.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.capstone.certificate_authority_data
}

output "worker_security_group_id" {
  value = aws_eks_cluster.capstone.worker_security_group_id
}