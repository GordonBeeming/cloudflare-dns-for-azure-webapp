# Create a CSR and generate a CA certificate
resource "tls_private_key" "main" {
  algorithm = "RSA"
}

resource "tls_cert_request" "main" {
  private_key_pem = tls_private_key.main.private_key_pem

  subject {
    common_name  = var.main_hostname
    organization = var.cert_organization
  }
}

resource "cloudflare_origin_ca_certificate" "main" {
  csr                = tls_cert_request.main.cert_request_pem
  hostnames          = [var.main_hostname]
  request_type       = "origin-rsa"
  requested_validity = 5475
  provider = cloudflare.cacert
}

resource "cloudflare_record" "main" {
  zone_id         = var.cloudflare_zone_id
  name            = var.main_hostname
  value           = data.dns_a_record_set.main.addrs[0]
  type            = "A"
  ttl             = 1
  proxied         = true
  allow_overwrite = false
  provider = cloudflare.default
}

resource "cloudflare_record" "main_txt_verify" {
  zone_id         = var.cloudflare_zone_id
  name            = "asuid.${var.main_hostname}"
  value           = data.azurerm_linux_web_app.main.custom_domain_verification_id
  type            = "TXT"
  ttl             = 1
  proxied         = false
  allow_overwrite = false
  provider = cloudflare.default
}

resource "random_uuid" "main_pfx_pass" {
}

resource "pkcs12_from_pem" "main_domain_pfx" {
  password        = random_uuid.main_pfx_pass.result
  cert_pem        = cloudflare_origin_ca_certificate.main.certificate
  private_key_pem = tls_private_key.main.private_key_pem
}

variable "main_dns_record" {
  type = string
}

variable "main_hostname" {
  type = string
}

variable "cert_organization" {
  type = string
}
