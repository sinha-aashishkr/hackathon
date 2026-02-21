resource "google_service_account" "gke_nodes" {
  account_id   = "${var.env}-gke-node-sa"
  display_name = "GKE Node Service Account"
}

resource "google_project_iam_member" "node_role" {
  project = var.project_id
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "artifact_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}