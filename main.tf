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
  
resource "azurerm_storage_account" "my_stor" {
  name                     = "mystor802"
  resource_group_name      = "my-reso1"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"

}

