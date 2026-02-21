# 1. The GKE Cluster (Control Plane)
resource "google_container_cluster" "cluster" {
  name     = "${var.env}-gke"
  location = var.region # Regional for High Availability

  network    = var.vpc
  subnetwork = var.private_subnet

  # Best Practice: Delete the default pool to use a custom one below
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

# 2. The Zonal Node Pool (Workers)
resource "google_container_node_pool" "nodes" {
  name       = "${var.env}-nodepool"
  cluster    = google_container_cluster.cluster.id
  location   = var.region

  # CRITICAL: This restricts nodes to ONE zone only.
  node_locations = ["${var.region}-a"]

  # Total Nodes = node_count (1) * node_locations (1) = 1 Node total
  node_count = 1

  node_config {
    machine_type    = "e2-medium"
    service_account = var.node_sa
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}