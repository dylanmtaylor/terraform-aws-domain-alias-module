###############################################################################
#### CloudFront CDN of S3 Bucket
###############################################################################

resource "aws_cloudfront_distribution" "redirect_distribution" {
  depends_on = [aws_acm_certificate_validation.domain_alias]

  origin {
    domain_name = aws_s3_bucket.redirect_bucket.website_endpoint
    origin_id   = local.origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only" # S3 doesn't support https for website endpoints.
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  
  enabled         = true
  is_ipv6_enabled = true
  comment         = coalesce(var.comment, "Provides redirects for ${var.domain_name}")
  http_version    = "http2and3"

  # DNS Aliases
  aliases = local.all_domains

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 300
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }
  }

  price_class = var.cloudfront_price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.domain_alias.arn
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method       = "sni-only"
  }
}