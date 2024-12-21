# main.tf 1
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_key_vault" "example" {
  name                        = "example-keyvault"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "get",
      "list",
      "create",
      "delete",
      "update",
      "import",
      "recover",
      "backup",
      "restore",
    ]

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "recover",
      "backup",
      "restore",
    ]

    certificate_permissions = [
      "get",
      "list",
      "create",
      "delete",
      "import",
      "update",
      "managecontacts",
      "getissuers",
      "listissuers",
      "setissuers",
      "deleteissuers",
    ]
  }
}

# variables.tf
variable "tenant_id" {
  description = "The Tenant ID for the Azure Active Directory."
  type        = string
}

variable "object_id" {
  description = "The Object ID of the user or application with permissions."
  type        = string
}

# outputs.tf file
output "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  value       = azurerm_key_vault.example.id
}

output "key_vault_uri" {
  description = "The URI of the Azure Key Vault."
  value       = azurerm_key_vault.example.vault_uri
}
  