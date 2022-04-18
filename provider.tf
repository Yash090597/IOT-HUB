terraform{
    required_providers{
        azurerm={
            source      =       "hashicorp/azurerm"
            version     =       "~>3.0"
        }
    }
}
provider "azurerm"{

    subscription_id              = var.sub_id
    tenant_id                    = var.tenant_id
    skip_provider_registration   = true
    features{
        key_vault {
            purge_soft_delete_on_destroy  = true
        }
    }
}