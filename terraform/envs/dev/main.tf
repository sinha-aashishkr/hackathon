module "network" {
  source       = "../../modules/network"
  env          = var.env
  region       = "asia-south1"
  public_cidr  = "10.10.1.0/24"
  private_cidr = "10.10.2.0/24"
}

module "iam" {
  source     = "../../modules/iam"
  env        = var.env
  project_id = var.project_id
}

module "artifact_registry" {
  source = "../../modules/artifact-registry"
  env    = var.env
  region = "asia-south1"
}

module "gke" {
  source         = "../../modules/gke"
  env            = var.env
  region         = "asia-south1"
  project_id     = var.project_id
  vpc            = module.network.vpc_id
  private_subnet  = module.network.private_subnet_id
  node_sa         = module.iam.node_sa_email
}