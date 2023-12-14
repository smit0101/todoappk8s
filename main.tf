

variable "gcp_sa_key" {
  description = "Google Cloud service account key file"
}
variable "project_id" {
  description = "Google Cloud project ID"
  default     = "smitkalkanik8s"
}

variable "region" {
  description = "GCP region for the cluster"
  default     = "us-central1-a"
}

provider "google" {
  #credentials = file(env.GCP_SA_KEY)
  project     = var.project_id
  region      = var.region
}

resource "google_container_cluster" "todocluster" {
  name               = "todocluster"
  location           = var.region
  remove_default_node_pool = true
  initial_node_count = 1
}





resource "google_container_node_pool" "nodepool1" {
  name       = "nodepool1"
  location   = var.region
  cluster    = google_container_cluster.todocluster.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    image_type   = "COS_CONTAINERD"
  }
}

resource "google_container_node_pool" "nodepool2" {
  name       = "nodepool2"
  location   = var.region
  cluster    = google_container_cluster.todocluster.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    image_type   = "COS_CONTAINERD"
  }
}
