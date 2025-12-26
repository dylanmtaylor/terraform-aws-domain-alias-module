###############################################################################
#### TLS Certificates
###############################################################################

resource "aws_acm_certificate" "domain_alias" {
  domain_name               = var.domain_name
  subject_alternative_names = [for subdomain in var.subdomains : "${subdomain}.${var.domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "domain_alias" {
  certificate_arn         = aws_acm_certificate.domain_alias.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}