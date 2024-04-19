variable "project" {
  type        = string
  description = "The GCP project that you want to create resources in."
}

variable "dataset_id" {
  type        = string
  description = "The dataset that you want Fullstory to use for data integrations."
}
