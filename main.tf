module "vm" {
  for_each             = var.tools
  source               = "./vm-module"
  component            = each.key
  ssh_password         = var.ssh_password
  ssh_username         = var.ssh_username
  port                 = each.value["port"]
  #role_definition_name = each.value["role_definition_name"]
}

variable "tools" {
  default = {

    vault = {
      port                 = 8200
      #role_definition_name = null
    }

    github-runner = {
      port                 = 443
      #role_definition_name = "Contributor"
    }

#     jenkins = {
#       port = 8080
#     }
#
#     jenkins-agent = {
#       port = 8080
#     }
#
#     prometheus = {
#       port = 9090
#     }
#
#     prom-node = {
#       port = 9100
#     }

#     sonarqube = {
#       port = 9000
#     }

  }
}

variable "ssh_username" {}
variable "ssh_password" {}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup-1"
    storage_account_name = "d82tfstatesnew"
    container_name       = "tools-tf-state"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a906d619-0839-4738-a908-227a8b69d458"
}


