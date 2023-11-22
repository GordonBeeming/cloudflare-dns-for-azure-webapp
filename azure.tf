resource "azurerm_app_service_certificate" "main" {
  name                = "main-${var.environment_name}-domain-cert"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  pfx_blob            = pkcs12_from_pem.main_domain_pfx.result
  password            = random_uuid.main_pfx_pass.result
}

resource "time_sleep" "main_wait_for_txt" {
  depends_on = [cloudflare_record.main_txt_verify]

  create_duration = "15s"
}

resource "azurerm_app_service_custom_hostname_binding" "main" {
  hostname            = var.main_hostname
  app_service_name    = data.azurerm_linux_web_app.main.name
  resource_group_name = data.azurerm_resource_group.main.name

  depends_on = [
    time_sleep.main_wait_for_txt
  ]
}

resource "azurerm_app_service_certificate_binding" "main" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.main.id
  certificate_id      = azurerm_app_service_certificate.main.id
  ssl_state           = "SniEnabled"
}
