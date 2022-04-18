data "azurerm_resource_group" "example" {
  name     = var.rgname
}

resource "azurerm_storage_account" "example" {
  name                     = var.stg_acc_name
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  count                 = var.enablecont == true ? length(var.stg_cont_name) : 0
  name                  = var.stg_cont_name[count.index]
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}