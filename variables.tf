variable "project" {
  type        = string
  description = "The target GCP project that will be used for all resources."
}

variable "dataset_id" {
  type        = string
  description = "The dataset that Fullstory will use to sync data."
}

variable "service_account_name" {
  type = string
  description = "The name of the service account to use with Fullstory"
  default = "fullstory-bigquery-setup"
}
