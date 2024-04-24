resource "google_bigquery_dataset" "main" {
  dataset_id                  = "fullstory"
  friendly_name               = "Fullstory"
  description                 = "This the dataset for all Fullstory data to live in."
  location                    = "US"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }

  access {
    role   = "READER"
    domain = "my-company.com"
  }
}

module "fullstory_bigquery_setup" {
  source     = "fullstorydev/fullstory-bigquery-setup/google"
  dataset_id = google_bigquery_dataset.main.dataset_id
  project    = "my-project-id"
}

# This block is important so that the value can be viewed with `terraform output`.
output "fullstory_bigquery_setup_service_account_private_key" {
  value     = module.fullstory_bigquery_setup.service_account_private_key
  sensitive = true
}
