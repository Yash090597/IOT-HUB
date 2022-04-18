module "EventHub" {
    source                  = "./modules/EventHub"
    rgname                  = var.rgname
    eventhub_namespace_name = var.eventhub_namespace_name 
    location                = var.location
    sku                     = var.sku
    eventhub_name           = var.eventhub_name
    eventhub_rule_name      = var.eventhub_rule_name
}

module "Storage-Account" {
    source                  = "./modules/StorageAccount"
    rgname                  = var.rgname
    location                = var.location
    stg_acc_name            = var.stg_acc_name
    enablecont              = var.enablecont
    stg_cont_name           = var.stg_cont_name
}
module "IOT-HUB" {
    source                  = "./modules/IOT-HUB"
    rgname                  = var.rgname
    location                = var.location
    iot_hub_name            = var.iot_hub_name
    pep1_type               = var.pep1_type
    iot_hub_pep1            = var.iot_hub_pep1
    pep2_type               = var.pep2_type
    iot_hub_pep2            = var.iot_hub_pep2
    stg_acc_name            = var.stg_acc_name
    eventhub_namespace_name = var.eventhub_namespace_name
    eventhub_name           = var.eventhub_name
    eventhub_rule_name      = var.eventhub_rule_name
    enablecont              = var.enablecont
    stg_cont_name           = var.stg_cont_name
    depends_on              = [module.EventHub, module.Storage-Account]
}