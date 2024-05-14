module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source              = "./modules/eks"
  subnets             = module.vpc.public_subnets
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_role_arn   = module.iam.eks_node_role_arn
}


module "ecr" {
  source = "./modules/ecr"
}
