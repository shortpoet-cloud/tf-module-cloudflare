data "cloudflare_accounts" "main" {
  name = "Soriano.carlos@gmail.com's Account"
}

resource "cloudflare_zone" "shortpoet" {
  zone       = "shortpoet.com"
  account_id = data.cloudflare_accounts.main.accounts[0].id
}

output "accounts" {
  description = "The Cloudflare accounts matching the account name, which own the zone."
  value       = data.cloudflare_accounts.main
}
