# Azure Infrastructure for XYZCorp
This repository contains the infrastructure as code for XYZCorp. The infrastructure is deployed on Azure using Terraform.

## Prerequisites
- Terraform
- AzureRM Provider

## Usage
This is demo repository. To use it properly with provided CI/CD pipelines repository should be forked and remote state should be configured.

1. Fork the repository
2. Configure remote state in `provider.tf` file. Uncomment the remote state block and provide the required values.
```hcl
backend "azurerm" {
  resource_group_name  = "rg-terraform-state"
  storage_account_name = "xyzcorptfstate"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
}
```
3. Create a service principal which has contributor access to the subscription.
```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>"
```
4. Configure the service principal in the GitHub secrets.
```bash
ARM_SUBSCRIPTION_ID = <subscription_id>
ARM_CLIENT_ID = <client_id>
ARM_CLIENT_SECRET = <client_secret>
ARM_TENANT_ID = <tenant_id>
```
5. Create a new branch and make the required changes.
6. Raise a pull request and merge the changes.
7. The CI/CD pipeline will be triggered and the infrastructure will be deployed.

### VPN Gateway
VPN Gateway is deployed as a part of App1 module. On-premis configuration is not included in this repository. It should be configured separately. Instructions for on-premis configuration can be found [here](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices?WT.mc_id=Portal-Microsoft_Azure_HybridNetworking).


### Repository Structure
Apps are deployed in separate modules. Each module has its own `main.tf` file which contains the resources required for the app.

Apps are deployed in root `main.tf` file. This file contains the modules for each app.

Each application should be modified in its respective module. Modules are located in the `apps` directory.

### CI/CD Pipeline
The CI/CD pipeline is configured using GitHub Actions. The pipeline is triggered on every push to the repository. The pipeline has the following stages:

1. Terraform Init
2. Terraform Plan
3. Terraform Apply
