output "service_account" {
  description = "The Fullstory service account that Fullstory will use to load data."
  value       = google_service_account.main
}

output "service_account_private_key" {
  description = "The private key that can be used in the Fullstory app when configuring the BigQuery integration."
  value       = google_service_account_key.main.private_key
  sensitive   = true
}
