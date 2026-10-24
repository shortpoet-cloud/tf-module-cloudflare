variable "account_id" {
  description = "The dev account's ID, from the dashboard after the account is made by hand."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{32}$", var.account_id))
    error_message = "account_id must be the 32 lower-case hex digits the dashboard shows."
  }
}

variable "account_name" {
  description = "The dev account's name."
  type        = string
}

variable "enforce_twofactor" {
  description = "Whether every member of the dev account must use two-factor authentication."
  type        = bool
}

variable "zone_name" {
  description = "The domain the dev account serves."
  type        = string
}

variable "zone_settings" {
  description = "The dev zone's settings by setting ID, each with its string value."
  type        = map(string)
}
