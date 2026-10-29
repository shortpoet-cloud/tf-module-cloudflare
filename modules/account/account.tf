# The account itself is made by hand (only tenant admins can create one through
# the API); the calling root imports it into this resource by its ID. Deleting
# it is refused for the same reason.
resource "cloudflare_account" "this" {
  name = var.account_name
  settings = {
    enforce_twofactor = var.enforce_twofactor
  }

  lifecycle {
    prevent_destroy = true
  }
}
