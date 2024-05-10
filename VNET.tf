resource "azurerm_virtual_network" "my_vnet1" {
  name                = "my-vnet1"
  location            = "East US"
  resource_group_name = "my-reso1"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "mysubnet1"
    address_prefix = "10.0.1.0/24"
  }

}