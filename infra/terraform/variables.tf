# GLOBAL
variable "project_id" {
  description = "Project ID"
  type        = string
}
variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

# CLOUD RUN
variable "docker_image_url" {
  description = "Docker image URL"
  type        = string
}