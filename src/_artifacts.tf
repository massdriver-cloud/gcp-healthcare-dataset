resource "massdriver_artifact" "dataset" {
  field                = "dataset"
  provider_resource_id = google_healthcare_dataset.main.id
  name                 = "GCP Healthcare Dataset ${var.md_metadata.name_prefix}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          grn = google_healthcare_dataset.main.id
        }
        security = {
          iam = {
            read = {
              role      = "roles/healthcare.datasetViewer"
              condition = "resource.name.endsWith(\"${var.md_metadata.name_prefix}\")"
            }
            admin = {
              role      = "roles/healthcare.datasetAdmin"
              condition = "resource.name.endsWith(\"${var.md_metadata.name_prefix}\")"
            }
          }
        }
      }
      specs = {
        gcp = {
          region = google_healthcare_dataset.main.location
        }
      }
    }
  )
}
