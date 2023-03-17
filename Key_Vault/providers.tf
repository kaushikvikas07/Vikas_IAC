terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }

}
provider "azurerm" {
  # Configuration options
  features {}
  tenant_id       = "f938af4c-eee5-41ef-ab2c-c7b60ab5db70"
  subscription_id = "b0df534d-aa3c-4d24-8bc6-c013d5a12a8a"
  client_id       = "d86b1d36-1cf2-43f0-bc88-fbb5fdc6de58"
  client_secret   = "fLt8Q~QTTOD565tizZBMAQXNWinRwPQdrxzsocer"
}