<a href="https://fullstory.com"><img src="https://github.com/fullstorydev/terraform-google-fullstory-bigquery-setup/blob/main/assets/fs-logo.png?raw=true"></a>

# terraform-google-fullstory-bigquery-setup

[![GitHub release](https://img.shields.io/github/release/fullstorydev/terraform-google-fullstory-bigquery-setup.svg)](https://github.com/fullstorydev/terraform-google-fullstory-bigquery-setup/releases/)

This module creates all the proper permissions and service accounts so that Fullstory can connect to the dataset and load data. For more information checkout [this KB article](https://help.fullstory.com/hc/en-us/articles/6295305958551-Google-BigQuery).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | The dataset that Fullstory will use to sync data. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The target GCP project that will be used for all resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The Fullstory service account that Fullstory will use to load data. |
| <a name="output_service_account_private_key"></a> [service\_account\_private\_key](#output\_service\_account\_private\_key) | The private key that can be used in the Fullstory app when configuring the BigQuery integration. |

## Usage

```hcl
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
#
# The secret can be copied to your clipboard with:
# terraform output -raw fullstory_bigquery_setup_service_account_private_key | base64 -d | pbcopy
output "fullstory_bigquery_setup_service_account_private_key" {
  value     = module.fullstory_bigquery_setup.service_account_private_key
  sensitive = true
}
```
<!-- END_TF_DOCS -->

## Obtaining the private key

This module outputs the private key that can be pasted into Fullstory in order for Fullstory to connect to your database. After using this module, you must output the value of the private in your root module ([see above example](#usage)). Once that is done, you should be able to access the private key value using the following command:

```bash
terraform output -raw <name of your output varible > | base64 -d | pbcopy
```

Alternatively, you can generate a key from the service account section of the IAM console in GCP.

## Contributing

See [CONTRIBUTING.md](https://github.com/fullstorydev/terraform-google-fullstory-bigquery-setup/blob/main/.github/CONTRIBUTING.md) for best practices and instructions on setting up your dev environment.
