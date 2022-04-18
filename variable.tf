variable "sub_id" {}
variable "tenant_id" {}
#
variable "rgname" {}
variable "eventhub_namespace_name" {}
variable "location" {}
variable "sku" {}
variable "eventhub_name" {}
variable "eventhub_rule_name" {}
#

#
variable "stg_acc_name" {}
variable "enablecont" {}
variable "stg_cont_name" {
    type = list(string)
}
#

#
variable "iot_hub_name" {}
variable "pep1_type" {}
variable "iot_hub_pep1" {}
variable "pep2_type" {}
variable "iot_hub_pep2" {}
#