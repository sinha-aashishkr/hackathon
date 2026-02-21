resource "google_compute_network" "vpc" {
  name                    = "${var.env}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = "${var.env}-public-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.public_cidr
}

resource "google_compute_subnetwork" "private" {
  name                     = "${var.env}-private-subnet"
  region                   = var.region
  network                  = google_compute_network.vpc.id
  ip_cidr_range            = var.private_cidr
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "${var.env}-router"
  region  = var.region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.env}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}