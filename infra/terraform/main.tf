# Cloud Run Service
resource "google_cloud_run_v2_service" "website_service" {
  name                = "website-amadomaker-service"
  location            = var.region
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

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