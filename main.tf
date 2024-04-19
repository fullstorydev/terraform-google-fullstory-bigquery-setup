resource "google_service_account" "main" {
  account_id   = "fullstory-data-integrations"
  display_name = "Fullstory Data Integrations"
  description  = "Used by Fullstory to load data into data integrations."
}

resource "google_project_iam_member" "main" {
  project = var.project
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.main.email}"
}

resource "google_bigquery_dataset_iam_member" "main" {
  dataset_id = var.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.main.email}"
}
