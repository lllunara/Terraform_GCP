Creating a Postgres Engine Master Instance on GCP with Terraform
This guide will show you how to create a Postgres Engine master instance on Google Cloud Platform (GCP) using Terraform.

Prerequisites
A GCP account
A project created in GCP
The Google Cloud SDK installed on your machine
Terraform installed on your machine
A service account with the correct permissions to create a Postgres Engine instance
Step 1: Configure the Terraform backend
Create a new directory for your Terraform project and navigate to it in your terminal.

Create a main.tf file in the directory and paste the following code:

Copy code
resource "google_sql_database_instance" "master_instance" {
  name             = "master-instance"
  database_version = "POSTGRES_14"
  region           = "us-west1"

  settings {
    tier                 = "db-custom-2-13312"
    disk_size    = 100
    disk_autoresize_limit  = 110
    disk_type = "PD_SSD" 
    location_preference {
      zone = "us-west1-a"
    }
  }
}

This code defines the configuration for your Postgres Engine master instance.

Step 2: Authenticate with GCP
Before you can run Terraform commands, you need to authenticate with GCP. You can do this by setting the GOOGLE_APPLICATION_CREDENTIALS environment variable to the path of a JSON file containing your service account credentials.

You can also run the gcloud auth application-default login command to authenticate with your Google Cloud account.

Step 3: Initialize Terraform
Run the following command to initialize Terraform:

Copy code
terraform init
This will download the necessary providers and configure the backend for storing your Terraform state.

Step 4: Create the Postgres Engine instance
Run the following command to create the Postgres Engine instance:

Copy code
'terraform apply'
This will prompt you to confirm the creation of the resources. Type yes and press enter to proceed.

Step 5: Verify the Postgres Engine instance
You can verify that the Postgres Engine instance was created by visiting the Cloud SQL page in the GCP console. You should see your new instance listed there.

Cleanup
When you're finished with the Postgres Engine instance, you can run the following command to delete it:

Copy code
'terraform destroy'
This will prompt you to confirm the deletion of the resources. Type yes and press enter to proceed.

Note: The code snippet provided does not include the availability_type and backup_configuration, but you can add them in the same way as location_preference is defined.
