locals {
  bucket_name = "domain-redirects-${replace(var.domain_name, ".", "-")}"
  origin_id   = "web_redirects_${replace(var.domain_name, ".", "_")}"
  
  # Create list of all domains (apex domain + subdomains)
  all_domains = concat(
    [var.domain_name],
    [for subdomain in var.subdomains : "${subdomain}.${var.domain_name}"]
  )
}