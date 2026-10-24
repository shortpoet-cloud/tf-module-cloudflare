terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.28"
    }
  }
  required_version = ">= 1.11"
}

# Reads CLOUDFLARE_API_TOKEN: the dev account's own token for Terraform (README).
provider "cloudflare" {}

# The dev account is made by hand in the dashboard; this brings it under the
# module by the ID the dashboard shows.
import {
  to = module.account.cloudflare_account.this
  id = var.account_id
}

module "account" {
  source = "../../modules/account"

  account_name      = var.account_name
  enforce_twofactor = var.enforce_twofactor
  zone_name         = var.zone_name
  zone_settings     = var.zone_settings
}

output "zone_status" {
  description = "The zone's status: pending until the registration moves to this account, then active."
  value       = module.account.zone_status
}

output "zone_name_servers" {
  description = "The Cloudflare nameservers the zone's registration must name."
  value       = module.account.zone_name_servers
}
