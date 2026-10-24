# account_id is added once the account exists (README, step 1).
account_name      = "shortpoet-dev"
enforce_twofactor = true
zone_name         = "marshmallowmeat.com"

zone_settings = {
  always_use_https         = "on"
  automatic_https_rewrites = "on"
  min_tls_version          = "1.2"
  ssl                      = "strict"
  tls_1_3                  = "on"
}
