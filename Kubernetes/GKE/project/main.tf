terraform {
  required_version = " >= 0.12"
}

provider "google" {
    region = "us-central1"
}

resource "google_project" "nurs" {
  name = "nurs"
  project_id = "nurs-1234"
  billing_account = "01370A-7026B4-CBCC60"
}

resource "null_resource" "cluster" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "gcloud config set project ${google_project.nurs.project_id}"
  }
}

resource "null_resource" "unset-project" {
	provisioner "local-exec" {
	when = destroy
	command = "gcloud config unset project"
	}
}


resource "google_project_service" "project" {
  project = "nurs-1234"
  service = "compute.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "project1" {
  project = "nurs-1234"
  service = "container.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "project2" {
  project = "nurs-1234"
  service = "storage-api.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "project3" {
  project = "nurs-1234"
  service = "dns.googleapis.com"

  disable_dependent_services = true
}