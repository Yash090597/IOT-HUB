tenant_id               = "76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61"
sub_id                  = "a12ecb5c-6043-4acb-8e60-d48e89e3e262"
##############################################
rgname                  = "Terraform_Accelerator"
eventhub_namespace_name = "EventHub-IOT"
location                = "East US2"
sku                     = "Premium"
eventhub_name           = "EventHub-IOT"
eventhub_rule_name      = "EventHUb-Rule-IOT"
##############################################
stg_acc_name            = "stgacciot"
enablecont              = true
stg_cont_name           = ["stgcontiot"]
##############################################
iot_hub_name            = "IoTHub-001"
pep1_type               = "AzureIotHub.StorageContainer"
iot_hub_pep1            = "export"
pep2_type               = "AzureIotHub.EventHub"
iot_hub_pep2            = "export2"
##############################################