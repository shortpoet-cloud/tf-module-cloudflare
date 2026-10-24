# Cloudflare dev account

The `shortpoet-dev` account and its zone, `marshmallowmeat.com`. Steps 1, 2 and 4 are done by hand in the dashboard.

## 1. Make the account (by hand)

Dashboard → account switcher → **Create Account** → Free → name it `shortpoet-dev`.

Copy its account ID (Account home → the account's menu → **Copy account ID**). Add it to `terraform.tfvars`:

```hcl
account_id = "<32 hex digits>"
```

## 2. Make Terraform's token (by hand)

In `shortpoet-dev`: **Manage Account** → **Account API Tokens** → **Create Token** → **Custom token**.

| Permission | Access |
|---|---|
| Account · Account Settings | Edit |
| Zone · Zone | Edit |
| Zone · Zone Settings | Edit |
| Zone · DNS | Edit |

Resources: all zones in `shortpoet-dev`. Then store it:

```bash
PASSWORD_STORE_DIR=~/source/orgs/github/shortpoet-pass/tier-1 pass insert cloudflare/dev/terraform
```

## 3. Plan, then apply

```bash
(
  set -eo pipefail
  cd ~/source/orgs/github/shortpoet-cloud/tf-cloudflare/accounts/dev
  aws sts get-caller-identity --profile terraform-admin >/dev/null 2>&1 || aws sso login --profile terraform-admin --use-device-code
  CLOUDFLARE_API_TOKEN="$(PASSWORD_STORE_DIR=~/source/orgs/github/shortpoet-pass/tier-1 pass show cloudflare/dev/terraform)"
  export CLOUDFLARE_API_TOKEN
  terraform init -input=false
  terraform plan -input=false -out="$XDG_RUNTIME_DIR/cloudflare-dev.tfplan"
)
```

Expect `1 to import, 6 to add, 0 to destroy`: the account, the zone and five zone settings. The account shows one change only if its name or two-factor setting differs.

```bash
(
  set -eo pipefail
  cd ~/source/orgs/github/shortpoet-cloud/tf-cloudflare/accounts/dev
  CLOUDFLARE_API_TOKEN="$(PASSWORD_STORE_DIR=~/source/orgs/github/shortpoet-pass/tier-1 pass show cloudflare/dev/terraform)"
  export CLOUDFLARE_API_TOKEN
  terraform apply "$XDG_RUNTIME_DIR/cloudflare-dev.tfplan"
  rm "$XDG_RUNTIME_DIR/cloudflare-dev.tfplan"
  terraform output zone_status
)
```

Expect `"pending"`.

## 4. Move the domain's registration (by hand)

In the main account: **Domain Registration** → **Manage Domains** → `marshmallowmeat.com` → **Configuration** → move it, giving the `shortpoet-dev` account ID. Accept the move in `shortpoet-dev`.

The main account's settings for the domain are lost, and the registration is transfer-locked for 30 days.

## 5. Check

```bash
(
  set -eo pipefail
  cd ~/source/orgs/github/shortpoet-cloud/tf-cloudflare/accounts/dev
  CLOUDFLARE_API_TOKEN="$(PASSWORD_STORE_DIR=~/source/orgs/github/shortpoet-pass/tier-1 pass show cloudflare/dev/terraform)"
  export CLOUDFLARE_API_TOKEN
  terraform apply -refresh-only -auto-approve -input=false >/dev/null
  terraform output zone_status
  terraform plan -input=false -detailed-exitcode
)
```

Expect `"active"`, then `No changes`.
