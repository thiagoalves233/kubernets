### DEV

output "resource-group-aks-name" {
    value =azurerm_resource_group.kubernetes.name
}
output "resource-group-aks-location" {
    value =azurerm_resource_group.kubernetes.location
}

### PROD

output "prod-resource-group-aks-name" {
    value =azurerm_resource_group.prod-kubernetes.name
}
output "prod-resource-group-aks-location" {
    value =azurerm_resource_group.prod-kubernetes.location
}