###############################################################################
#### Route53 Records
###############################################################################

resource "aws_route53_record" "domain_alias_a" {
  for_each = toset(local.all_domains)
  
  zone_id = var.hosted_zone_id
  name    = each.value
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.redirect_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.redirect_distribution.hosted_zone_id
    evaluate_target_health = false # Not supported by CloudFront
  }
}

resource "aws_route53_record" "domain_alias_aaaa" {
  for_each = toset(local.all_domains)
  
  zone_id = var.hosted_zone_id
  name    = each.value
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.redirect_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.redirect_distribution.hosted_zone_id
    evaluate_target_health = false # Not supported by CloudFront
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.domain_alias.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = var.hosted_zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}