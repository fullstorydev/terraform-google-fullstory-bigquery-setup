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

module "fullstory_data_integration" {
  source     = "fullstorydev/fullstory-data-integration/google"
  dataset_id = google_bigquery_dataset.main.dataset_id
  project    = "my-project-id"
}
