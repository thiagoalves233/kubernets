#### DEV
output "vnet-backend-id" {
  value = azurerm_virtual_network.vnet-backend.id
}

output "lb-pubicip-backend-id" {
  value = azurerm_public_ip.lb-kubernetes-aksOut.id
}

output "subnet-backend-id" {
  value = azurerm_subnet.backend-subnet.id
}
#### PROD
output "prod-vnet-backend-id" {
  value = azurerm_virtual_network.prod-vnet-backend.id
}

output "prod-lb-pubicip-backend-id" {
  value = azurerm_public_ip.prod-lb-kubernetes-aksOut.id
}

output "prod-subnet-backend-id" {
  value = azurerm_subnet.prod-backend-subnet.id
}