
terraform {  
  required_providers {  
    azurerm = {  
      source  = "hashicorp/azurerm"  
      version = "3.102.0"  
    }  
  }  
}  
  
provider "azurerm" {  
  features {}  
}

data "azurerm_subnet" "mysubnet1" {  
  name                 = "mysubnet1"  
  virtual_network_name = azurerm_virtual_network.my_vnet1.name  
  resource_group_name  = azurerm_resource_group.my_reso.name  
}  
  
resource "azurerm_resource_group" "my_reso" {  
  name     = "my-reso1"  
  location = "East US"  
}  
  
resource "azurerm_virtual_network" "my_vnet1" {  
  name                = "my-vnet1"  
  location            = "East US"  
  resource_group_name = azurerm_resource_group.my_reso.name  
  address_space       = ["10.0.0.0/16"]  
  dns_servers         = ["10.0.0.4", "10.0.0.5"]  
  
  subnet {  
    name           = "mysubnet1"  
    address_prefix = "10.0.1.0/24"  
  }  
}  
  
resource "azurerm_network_interface" "my_interface1" {  
  name                = "my-interface1"  
  location            = "East US"  
  resource_group_name = azurerm_resource_group.my_reso.name  
  
  ip_configuration {  
    name                          = "internal"  
    subnet_id                     = data.azurerm_subnet.mysubnet1.id  
    private_ip_address_allocation = "Dynamic"  
  }  
  
  depends_on = [azurerm_virtual_network.my_vnet1]  
}  
  
resource "azurerm_windows_virtual_machine" "my_VM1" {  
  name                = "my-VM1"  
  resource_group_name = azurerm_resource_group.my_reso.name  
  location            = "East US"  
  size                = "Standard_F2"  
  admin_username      = "adminuser"  
  admin_password      = "User@111"  
  network_interface_ids = [  
    azurerm_network_interface.my_interface1.id,  
  ]  
  
  os_disk {  
    caching              = "ReadWrite"  
    storage_account_type = "Standard_LRS"  
  }  
  
  source_image_reference {  
    publisher = "MicrosoftWindowsServer"  
    offer     = "WindowsServer"  
    sku       = "2016-Datacenter"  
    version   = "latest"  
  }  
  
  depends_on = [azurerm_network_interface.my_interface1]  
}  
