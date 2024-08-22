## Google Cloud Healthcare Dataset

The Google Cloud Healthcare Dataset service allows you to manage and access healthcare data in a secure, compliant, and scalable manner. It supports storing, processing, and analyzing healthcare data in formats like DICOM, FHIR, and HL7v2.

### Design Decisions

- **Security Roles**: The dataset assigns IAM roles for both dataset viewers and administrators with conditions to restrict their permissions to datasets matching the specified name prefix.
- **Region Availability**: The dataset is created in the specified Google Cloud region, ensuring data locality and compliance with regional regulations.
- **API Enablement**: Necessary APIs such as `iam.googleapis.com` and `healthcare.googleapis.com` are enabled to ensure the proper functioning of the dataset.

### Runbook

#### Unable to Access the Healthcare Dataset

This issue arises when users cannot access the dataset due to permission issues.

Use `gcloud` to check the current IAM roles and bindings. This code retrieves the IAM policy for the healthcare dataset and helps determine if the correct permissions are assigned:

```sh
gcloud healthcare datasets get-iam-policy YOUR_DATASET_NAME --location=YOUR_REGION
```

Replace `YOUR_DATASET_NAME` and `YOUR_REGION` with the actual dataset name and region. 

The output should display the IAM policy bindings. Verify that the roles `roles/healthcare.datasetViewer` and `roles/healthcare.datasetAdmin` are properly assigned.

#### Dataset Not Found

If you encounter an error indicating that the dataset does not exist, you can verify its existence using the following command:

```sh
gcloud healthcare datasets list --location=YOUR_REGION
```

This command lists all the healthcare datasets in the specified region. Ensure that your dataset is listed in the output.

#### Error Creating Dataset

If there is an error during dataset creation, ensure that the necessary APIs are enabled. Check which services are enabled:

```sh
gcloud services list --enabled
```

Verify that `iam.googleapis.com` and `healthcare.googleapis.com` are among the enabled services. If not, enable them using:

```sh
gcloud services enable iam.googleapis.com healthcare.googleapis.com
```

After ensuring the APIs are enabled, attempt to create the dataset again.

