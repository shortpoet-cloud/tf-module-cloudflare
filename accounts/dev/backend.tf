# State lives in the state bucket that tf-root/state-bucket/aws manages. encrypt
# sends the SSE header on the state and on its .tflock object, which the state
# bucket's policy requires of every put.
terraform {
  backend "s3" {
    region       = "us-east-1"
    bucket       = "341864192726-terraform-backend"
    key          = "tf-cloudflare/accounts/dev/terraform.tfstate"
    profile      = "terraform-admin"
    encrypt      = true
    use_lockfile = true
  }
}
