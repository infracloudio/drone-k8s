resource "google_container_cluster" "primary" {
  name               = "k8s-cicd"
  zone               = "${var.region_zone}"
  initial_node_count = "${var.node_count}"
  project = "${var.project}"
  master_auth {
    username = "lorne"
    password = "malvo"
  }

  node_config {
    machine_type = "${var.machine_type}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}