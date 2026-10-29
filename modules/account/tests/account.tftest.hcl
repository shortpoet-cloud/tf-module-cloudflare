# Runs against a mock provider: no Cloudflare credentials or API calls.
mock_provider "cloudflare" {}

variables {
  account_name      = "test-account"
  enforce_twofactor = true
  zone_name         = "example.com"
  zone_settings = {
    always_use_https = "on"
    min_tls_version  = "1.2"
  }
}

run "zone_belongs_to_account" {
  command = apply

  assert {
    condition     = cloudflare_zone.this.account.id == cloudflare_account.this.id
    error_message = "The zone must be created in the managed account."
  }

  assert {
    condition     = cloudflare_zone.this.name == "example.com" && cloudflare_zone.this.type == "full"
    error_message = "The zone must be the named domain, with full DNS."
  }
}

run "account_enforces_twofactor" {
  command = plan

  assert {
    condition     = cloudflare_account.this.settings.enforce_twofactor == true
    error_message = "enforce_twofactor must reach the account's settings."
  }
}

run "each_zone_setting_is_one_resource" {
  command = apply

  assert {
    condition     = length(cloudflare_zone_setting.this) == 2
    error_message = "Every entry of zone_settings must become one zone setting."
  }

  assert {
    condition     = cloudflare_zone_setting.this["min_tls_version"].value == "1.2" && cloudflare_zone_setting.this["min_tls_version"].zone_id == cloudflare_zone.this.id
    error_message = "A zone setting must carry its value and point at the zone."
  }
}
