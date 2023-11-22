data "azurerm_resource_group" "main" {
  name     = var.resource_group_name
}

data "azurerm_linux_web_app" "main" {
  name                = var.web_app_name
  resource_group_name = var.resource_group_name
}

data "dns_a_record_set" "main" {
  host = data.azurerm_linux_web_app.main.default_hostname
}

variable "web_app_name" {
  type = string  
}

output "main_resource_group" {
  value = data.azurerm_resource_group.main.name
}
