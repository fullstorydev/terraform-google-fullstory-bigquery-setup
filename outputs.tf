output "service_account" {
  description = "The Fullstory service account that Fullstory will use to load data into data integrations."
  value       = google_service_account.main
}
