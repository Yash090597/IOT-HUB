data "azurerm_resource_group" "example" {
  name     = var.rgname
}

data "azurerm_storage_account" "example" {
  name                  = var.stg_acc_name
  resource_group_name   = data.azurerm_resource_group.example.name 
}

data "azurerm_eventhub_namespace" "example" {
  name                = var.eventhub_namespace_name
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_eventhub" "example" {
  name                = var.eventhub_name
  resource_group_name = data.azurerm_resource_group.example.name
  namespace_name      = data.azurerm_eventhub_namespace.example.name
}

data "azurerm_eventhub_authorization_rule" "example" {
  name                = var.eventhub_rule_name
  namespace_name      = data.azurerm_eventhub_namespace.example.name
  eventhub_name       = data.azurerm_eventhub.example.name
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_storage_container" "example" {
  count                = var.enablecont == true ? length(var.stg_cont_name) : 0
  name                 = var.stg_cont_name[count.index]
  storage_account_name = data.azurerm_storage_account.example.name
}

resource "azurerm_iothub" "example" {
  count               = var.enablecont == true ? length(var.iot_hub_name) : 0
  name                = var.iot_hub_name
  resource_group_name = data.azurerm_resource_group.example.name
  location            = var.location
  sku {
    name     = "S1"
    capacity = "1"
  }
  endpoint {
    type                       = var.pep1_type       #"AzureIotHub.StorageContainer"
    connection_string          = data.azurerm_storage_account.example.primary_blob_connection_string
    name                       = var.iot_hub_pep1
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    container_name             = data.azurerm_storage_container.example[0].name
    encoding                   = "Avro"
    file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
  }
  endpoint {
    type              = var.pep2_type             #"AzureIotHub.EventHub"
    connection_string = data.azurerm_eventhub_authorization_rule.example.primary_connection_string
    name              = var.iot_hub_pep2
  }
  route {
    name           = var.pep1_type
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = [var.pep1_type]
    enabled        = true
  }
  route {
    name           = var.pep2_type
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = [var.pep2_type]
    enabled        = true
  }
  enrichment {
    key            = "tenant"
    value          = "$twin.tags.Tenant"
    endpoint_names = [var.pep1_type, var.pep2_type]
  }

  cloud_to_device {
    max_delivery_count = 30
    default_ttl        = "PT1H"
    feedback {
      time_to_live       = "PT1H10M"
      max_delivery_count = 15
      lock_duration      = "PT30S"
    }
  }
  tags = {
    purpose = "testing"
  }
}