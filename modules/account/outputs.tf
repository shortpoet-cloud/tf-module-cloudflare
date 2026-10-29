output "account_id" {
  description = "The account's ID."
  value       = cloudflare_account.this.id
}

output "zone_id" {
  description = "The zone's ID."
  value       = cloudflare_zone.this.id
}

output "zone_status" {
  description = "The zone's status: pending until its nameservers point at Cloudflare, then active."
  value       = cloudflare_zone.this.status
}

output "zone_name_servers" {
  description = "The Cloudflare nameservers the zone's registration must name."
  value       = cloudflare_zone.this.name_servers
}
