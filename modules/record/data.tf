data "cloudflare_zones" "domain" {
  filter {
    name = var.zone_name
  }
}
