# AWS_Instance using Terraform 
## 🚀 AWS Infrastructure with Terraform

This project uses **Terraform** to define and manage infrastructure on **Amazon Web Services (AWS)**. It sets up the necessary components, including the remote state backend, to ensure secure and collaborative infrastructure deployment.

-----

## 📋 Prerequisites

Before running this project, you must have the following installed and configured:

1.  **[Terraform](https://www.terraform.io/downloads.html):** Download and install the Terraform CLI.
2.  **AWS CLI:** Configure your AWS credentials.
3.  **Visual Studio Code (or preferred IDE):** For editing and running commands.
4.  **AWS Credentials:** An IAM user with appropriate permissions (e.g., `AdministratorAccess` for initial setup) configured on your local machine.

### Credential Configuration

Ensure your AWS credentials are set up using one of these methods:

  * **AWS CLI Profiles:** Use `aws configure` to set up a profile (e.g., `default`).
  * **Environment Variables:** Set the following variables in your terminal before running Terraform commands:
      * `$env:AWS_ACCESS_KEY_ID`
      * `$env:AWS_SECRET_ACCESS_KEY`

-----

## 🛠️ Project Setup and Initialization

Follow these steps to initialize the Terraform project and connect to the remote state backend.

### 1\. Initialize Terraform

Run the following command to download the necessary providers and initialize the **S3 remote backend** defined in your configuration files (`project.tf` or similar):

```bash
terraform init
```

  * **Note:** If this is the first time running `init`, Terraform will create the S3 bucket specified in your `backend "s3"` block to store the state file (`terraform.tfstate`).

### 2\. Validate Configuration

Check your configuration files for syntax errors and internal consistency:

```bash
terraform validate
```

-----

## ☁️ Deployment Workflow

### 1\. Plan the Changes

Generate an execution plan to see exactly what actions Terraform will take (create, modify, or destroy) before applying any changes:

```bash
terraform plan
```

### 2\. Apply the Changes

Apply the changes defined in the plan to provision the infrastructure in your AWS account. You will be prompted to confirm with `yes`.

```bash
terraform apply
```

-----

## 🧹 Clean Up

To destroy all infrastructure provisioned by this Terraform project, run the following command. **Use with caution**, as this will delete all resources and data.

```bash
terraform destroy
```

You will be prompted to confirm with `yes`.

-----

## 📁 Project Structure

The core files for this project are:

| File Name | Description |
| :--- | :--- |
| `main.tf` | Defines the primary AWS resources (e.g., VPC, EC2, S3). |
| `provider.tf` | **Defines the AWS provider, region, and the S3 backend configuration.** |
| `variables.tf` | Contains input variable declarations (e.g., region, environment tags). |
| `outputs.tf` | Defines output values (e.g., public IP, endpoint URL) after deployment. |
| `.gitignore` | Ensures sensitive files like `terraform.tfstate` and `.terraform/` are not committed to Git. |

-----

## ⚙️ Backend Configuration

This project uses an **AWS S3 bucket** for remote state management, which is crucial for team collaboration and security.

  * **Bucket Name:** `anjainaybackendcode123`
  * **State Key:** `code/terraform.tfstate`
  * **Region:** `us-east-1`

### Terraform Block (from your code):

```terraform
terraform {
  required_version = ">= 1.4"
  
  backend "s3" { 
    bucket = "anjainaybackendcode123"
    key    = "code/terraform.tfstate"
    region = "us-east-1"
  }
    
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}
```
