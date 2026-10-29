output "cloudflare_record_cname" {
  description = "The CNAME record pointing the subdomain at its target."
  value       = cloudflare_record.cname
}
