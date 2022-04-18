data "azurerm_resource_group" "example" {
  name     = var.rgname
}

resource "azurerm_eventhub_namespace" "example" {
  name                = var.eventhub_namespace_name 
  resource_group_name = data.azurerm_resource_group.example.name
  location            = var.location
  sku                 = var.sku
  zone_redundant      = true
}

resource "azurerm_eventhub" "example" {
  name                = var.eventhub_name 
  resource_group_name = data.azurerm_resource_group.example.name
  namespace_name      = azurerm_eventhub_namespace.example.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "example" {
  resource_group_name = data.azurerm_resource_group.example.name
  namespace_name      = azurerm_eventhub_namespace.example.name
  eventhub_name       = azurerm_eventhub.example.name
  name                = var.eventhub_rule_name
  send                = true
}