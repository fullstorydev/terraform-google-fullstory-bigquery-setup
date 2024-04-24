output "service_account" {
  description = "The Fullstory service account that Fullstory will use to load data."
  value       = google_service_account.main
}
