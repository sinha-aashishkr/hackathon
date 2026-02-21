resource "google_container_cluster" "cluster" {
  name     = "${var.env}-gke"
  location = var.region

  network    = var.vpc
  subnetwork = var.private_subnet

  remove_default_node_pool = true
  initial_node_count       = 1

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {}
}

resource "google_container_node_pool" "nodes" {
  name       = "${var.env}-nodepool"
  cluster    = google_container_cluster.cluster.name
  location   = var.region
  node_count = 2

  node_config {
    machine_type    = "e2-medium"
    service_account = var.node_sa
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}