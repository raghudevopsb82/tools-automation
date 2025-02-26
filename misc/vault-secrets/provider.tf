provider "vault" {
  #address = "http://vault-internal.azdevopsb82.online:8200"
  address = "http://10.1.0.8:8200"
  token   = var.token
}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup-1"
    storage_account_name = "d82tfstatesnew"
    container_name       = "vault-tf-states"
    key                  = "terraform.tfstate"

  }
}

provider "azurerm" {
  features {}
  subscription_id = "a906d619-0839-4738-a908-227a8b69d458"
}

variable "token" {}
