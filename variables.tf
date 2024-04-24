variable "project" {
  type        = string
  description = "The target GCP project that will be used for all resources."
}

variable "dataset_id" {
  type        = string
  description = "The dataset that Fullstory will use to sync data."
}
