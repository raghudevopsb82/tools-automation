resource "azurerm_public_ip" "main" {
  name                = "${var.component}-ip"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = {
    component = "${var.component}-ip"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.component}-nic"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.component}-nsg"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = var.component
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    component = "${var.component}-nsg"
  }
}


resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_dns_a_record" "private" {
  name                = "${var.component}-internal"
  zone_name           = "azdevopsb82.online"
  resource_group_name = data.azurerm_resource_group.main.name
  ttl                 = 10
  records             = [azurerm_network_interface.main.private_ip_address]
}

resource "azurerm_dns_a_record" "public" {
  name                = var.component
  zone_name           = "azdevopsb82.online"
  resource_group_name = data.azurerm_resource_group.main.name
  ttl                 = 10
  records             = [azurerm_public_ip.main.ip_address]
}


# resource "azurerm_virtual_machine" "main" {
#   depends_on            = [azurerm_network_interface_security_group_association.main, azurerm_dns_a_record.private]
#   name                  = var.component
#   location              = data.azurerm_resource_group.main.location
#   resource_group_name   = data.azurerm_resource_group.main.name
#   network_interface_ids = [azurerm_network_interface.main.id]
#   vm_size               = "Standard_B2s"
#
#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   delete_os_disk_on_termination = true
#
#
#   storage_image_reference {
#     id = "/subscriptions/7b6c642c-6e46-418f-b715-e01b2f871413/resourceGroups/trail1/providers/Microsoft.Compute/galleries/LDOTrail/images/rhel9-devops-practice/versions/04.12.2024"
#   }
#
#   storage_os_disk {
#     name              = var.component
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = var.component
#     admin_username = var.ssh_username
#     admin_password = var.ssh_password
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#   tags = {
#     component = var.component
#   }
#
# #   identity {
# #     type = "SystemAssigned"
# #   }
#
# }

# resource "azurerm_role_assignment" "role-assignment" {
#   depends_on           = [azurerm_virtual_machine.main]
#   count                = var.role_definition_name == null ? 0 : 1
#   scope                = data.azurerm_resource_group.main.id
#   role_definition_name = var.role_definition_name
#   principal_id         = azurerm_virtual_machine.main.identity[0].principal_id
# }


