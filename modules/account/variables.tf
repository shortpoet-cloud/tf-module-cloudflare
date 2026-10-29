variable "account_name" {
  description = "The account's name, as the dashboard shows it."
  type        = string
}

variable "enforce_twofactor" {
  description = "Whether every member of the account must use two-factor authentication."
  type        = bool
}

variable "zone_name" {
  description = "The domain the account serves, added as a Free zone with full DNS."
  type        = string
}

variable "zone_settings" {
  description = "Zone settings by setting ID (for example always_use_https), each with its string value."
  type        = map(string)
}
