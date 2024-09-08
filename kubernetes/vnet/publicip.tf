resource "azurerm_public_ip" "lb-kubernetes-aksOut" {
  name                = "lb-kubernetes-aksOut"
  location            = module.source.resource-group-aks-location
  resource_group_name = module.source.resource-group-aks-name
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = {
    environment = "dev-qa"
  }
}

##### PROD
resource "azurerm_public_ip" "prod-lb-kubernetes-aksOut" {
  name                = "prod-lb-kubernetes-aksOut"
  location            = module.source.prod-resource-group-aks-location
  resource_group_name = module.source.prod-resource-group-aks-name
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = {
    environment = "prod"
  }
}