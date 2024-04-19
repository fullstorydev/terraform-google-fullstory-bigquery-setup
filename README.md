<a href="https://fullstory.com"><img src="https://github.com/fullstorydev/terraform-google-fullstory-data-integration/blob/main/assets/fs-logo.png?raw=true"></a>

# terraform-google-fullstory-data-integration

[![GitHub release](https://img.shields.io/github/release/fullstorydev/terraform-google-fullstory-data-integration.svg)](https://github.com/fullstorydev/terraform-google-fullstory-data-integration/releases/)

This module creates all the proper permissions and service accounts so that Fullstory can connect to the dataset and load data. For more information checkout [this KB article](https://help.fullstory.com/hc/en-us/articles/6295305958551-Google-BigQuery).

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13  |
| <a name="requirement_google"></a> [google](#requirement_google)          | >= 5.0.0 |

## Inputs

| Name                                                            | Description                                                       | Type     | Default | Required |
| --------------------------------------------------------------- | ----------------------------------------------------------------- | -------- | ------- | :------: |
| <a name="input_dataset_id"></a> [dataset_id](#input_dataset_id) | The dataset that you want Fullstory to use for data integrations. | `string` | n/a     |   yes    |
| <a name="input_project"></a> [project](#input_project)          | The GCP project that you want to create resources in.             | `string` | n/a     |   yes    |

## Outputs

| Name                                                                             | Description                                                                                |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| <a name="output_service_account"></a> [service_account](#output_service_account) | The Fullstory service account that Fullstory will use to load data into data integrations. |

## Usage

### With Cloud DNS Record Creation

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
  source     = "fullstorydev/fullstory-data-integration/google"
  dataset_id = google_bigquery_dataset.main.dataset_id
  project    = "my-project-id"
}
```

<!-- END_TF_DOCS -->

## Contributing

See [CONTRIBUTING.md](https://github.com/fullstorydev/terraform-google-fullstory-cloud-relay/blob/main/.github/CONTRIBUTING.md) for best practices and instructions on setting up your dev environment.
