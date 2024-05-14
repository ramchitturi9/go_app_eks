variable "subnets" {
  type = list(string)
}

variable "eks_cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster"
}

variable "eks_node_role_arn" {
  description = "The ARN of the IAM role for the EKS nodes"
}

resource "aws_eks_cluster" "cluster" {
  name     = "goapp-prod-cluster"
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids = var.subnets
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "goapp-node-group"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.subnets

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
