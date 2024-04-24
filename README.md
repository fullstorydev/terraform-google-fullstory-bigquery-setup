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

module "fullstory_data_integration" {
  source     = "fullstorydev/fullstory-bigquery-setup/google"
  dataset_id = google_bigquery_dataset.main.dataset_id
  project    = "my-project-id"
}
```
<!-- END_TF_DOCS -->

## Obtaining the private key

Once this Terraform module has been applied, you can get the private key of the service account by running the following command:

```bash
terraform output -raw module.<name of your module>.service_account_private_key | base64 -d | pbcopy
```

## Contributing

See [CONTRIBUTING.md](https://github.com/fullstorydev/terraform-google-fullstory-bigquery-setup/blob/main/.github/CONTRIBUTING.md) for best practices and instructions on setting up your dev environment.
