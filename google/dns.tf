provider "Cloudflare" {
  email = "mailadresse"
  token = "token"
}

resource "Cloudflare_record" "test" {
  domain = var.domain
  name = var.subdomain
  value = "${google_compute_address.server-static.address}"
  type = "A"
  ttl = 3600
}
