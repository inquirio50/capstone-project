module "ec2_instances" {
  source = "./modules/ec2_instances"

  region = var.region
  instance_count = var.instance_count
}

module "eks_cluster" {
  source = "./modules/eks_cluster"

  region = var.region

  vpc_subnet_cidr_blocks = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]
}