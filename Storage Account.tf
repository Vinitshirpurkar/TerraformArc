resource "azurerm_resource_group" "my_reso" {  
  name     = "my-reso1"  
  location = "East US"  
}  
  
resource "azurerm_storage_account" "my_stor" {
  name                     = "mystore758"
  resource_group_name      = "my-reso1"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"

}
