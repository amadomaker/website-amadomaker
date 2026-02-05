terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.18.0"
    }
  }
  backend "gcs" {
    bucket = "placeholder"
    prefix = "placeholder"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}