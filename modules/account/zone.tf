resource "cloudflare_zone" "this" {
  account = {
    id = cloudflare_account.this.id
  }
  name = var.zone_name
  type = "full"
}

resource "cloudflare_zone_setting" "this" {
  for_each = var.zone_settings

  zone_id    = cloudflare_zone.this.id
  setting_id = each.key
  value      = each.value
}
