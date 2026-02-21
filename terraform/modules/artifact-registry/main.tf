resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "${var.env}-repo"
  format        = "DOCKER"
  description   = "Docker repo for ${var.env}"
}