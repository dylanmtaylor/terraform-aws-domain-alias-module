output "s3_bucket_id" {
  description = "The ID of the S3 bucket used for redirects"
  value       = aws_s3_bucket.redirect_bucket.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket used for redirects"
  value       = aws_s3_bucket.redirect_bucket.arn
}

output "s3_bucket_website_endpoint" {
  description = "The website endpoint of the S3 bucket"
  value       = aws_s3_bucket.redirect_bucket.website_endpoint
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.redirect_distribution.id
}

output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.redirect_distribution.arn
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.redirect_distribution.domain_name
}

output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.domain_alias.arn
}

output "domain_name" {
  description = "The full domain name of the alias"
  value       = var.domain_name
}

output "all_domains" {
  description = "List of all domains (apex + subdomains) that have DNS records"
  value       = local.all_domains
}

output "route53_records_ipv4" {
  description = "Map of Route53 A record names by domain"
  value       = { for domain, record in aws_route53_record.domain_alias_a : domain => record.name }
}

output "route53_records_ipv6" {
  description = "Map of Route53 AAAA record names by domain"
  value       = { for domain, record in aws_route53_record.domain_alias_aaaa : domain => record.name }
}