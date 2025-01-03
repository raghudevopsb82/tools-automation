provider "vault" {
  address = "http://vault-internal.azdevopsb82.online:8200"
  token = var.token
}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup-1"
    storage_account_name = "d82tfstates"
    container_name       = "vault-tf-states"
    key                  = "terraform.tfstate"

  }
}

provider "azurerm" {
  features {}
  subscription_id = "7b6c642c-6e46-418f-b715-e01b2f871413"
}

variable "token" {}
