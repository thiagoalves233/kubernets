resource "azurerm_resource_group" "kubernetes" {
  name     = "dev-mm-kubernetes"
  location = "Brazil South"
}

resource "azurerm_resource_group" "prod-kubernetes" {
  name     = "prod-mm-kubernetes"
  location = "Brazil South"
}