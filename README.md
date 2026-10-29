# tf-module-cloudflare

Terraform modules for Cloudflare. This repository holds modules only: no root here is planned or applied, and it keeps no state. Each account's root lives in `shortpoet-cloud/tf-cloudflare-accounts` and pins these modules by tag.

| Module | Provider | What it manages |
|---|---|---|
| `modules/account` | `cloudflare/cloudflare` `~> 5.28` | An account made by hand and imported by its ID, its two-factor setting, one zone, and that zone's settings |
| `modules/record` | v3 | A CNAME record in an existing zone |
| `modules/zone` | v3 | A zone |
| `modules/worker` | v3 | A Worker script |

Callers pin a tag, never a branch:

```hcl
source = "git::ssh://git@github.com/shortpoet-cloud/tf-module-cloudflare.git//modules/account?ref=v0.2.0"
```
