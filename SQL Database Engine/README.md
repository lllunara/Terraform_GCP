# SQL Server Database on GCP
This Terraform code creates a SQL Server database on Google Cloud Platform (GCP) with a master instance, a database, a user, and a read replica.

## Resources
+ google_sql_database_instance: Creates a "master" instance of a SQL Server database with the specified version, region, root password, and settings for tier and disk size.

+ google_sql_database: Creates a database with a specified name and links it to the "master" instance created previously.

+ google_sql_user: Creates a user with a specified name and password and links it to the "master" instance.

+ google_sql_database_instance with name "read_replica": Creates a read replica of the "master" instance in a different region with specified replica configuration, settings, and location preference. It also disables the backup configuration.

## Variables
This Terraform code uses the following variables:

+ region: The region where the master instance will be located.
+ root_password: The root password for the master instance.
+ tier: The tier for the master and read replica instances.
+ db_username: The username for the user.
+ db_password: The password for the user.
## Usage
Fill in the values for the variables in a terraform.tfvars file or pass them in as command-line options when running terraform apply.

Run terraform init to download the necessary provider plugins.

Run terraform apply to create the resources.

Run terraform destroy to delete the resources when they are no longer needed.

## Note
Make sure you have the necessary permissions to create resources on GCP and have the credentials set up.
Make sure to check the GCP SQL Server pricing before using this code in production.
It is always recommended to test this code in a development environment before using it in production.
This code is not meant to be used as it is, it requires customization and hardening according to the specific use case and requirements.