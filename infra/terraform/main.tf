# Cloud Run Service
resource "google_cloud_run_v2_service" "website_service" {
  name                = "website-amadomaker-service"
  location            = var.region
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  scaling {
    max_instance_count = 3
  }

  template {
    health_check_disabled = true
    containers {
      image = var.docker_image_url
      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
        }
      }
    }
  }
}

# IAM Policy para acesso público
resource "google_cloud_run_v2_service_iam_member" "public_access" {
  name     = google_cloud_run_v2_service.website_service.name
  location = google_cloud_run_v2_service.website_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}