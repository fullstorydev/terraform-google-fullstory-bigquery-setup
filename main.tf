resource "google_service_account" "main" {
  account_id   = "fullstory-bigquery-setup"
  display_name = "Fullstory BigQuery Setup"
  description  = "Used by Fullstory to load data into BigQuery"
}

resource "google_service_account_key" "main" {
  service_account_id = google_service_account.main.name
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
