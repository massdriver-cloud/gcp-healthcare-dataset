resource "google_healthcare_dataset" "main" {
  name      = var.md_metadata.name_prefix
  project   = var.gcp_authentication.data.project_id
  location  = var.region
  time_zone = var.time_zone

  depends_on = [
    module.apis
  ]
}
