variable "hosted_zone_id" {
  description = "The Route53 hosted zone ID where the domain alias record should be created"
  type        = string

  validation {
    condition     = can(regex("^Z[A-Z0-9]+$", var.hosted_zone_id))
    error_message = "Must be a valid Route53 hosted zone ID starting with 'Z'."
  }
}

variable "domain_name" {
  description = "The full domain name to create the alias for (e.g., 'example.com')"
  type        = string

  validation {
    condition     = !startswith(var.domain_name, ".") && !endswith(var.domain_name, ".")
    error_message = "Domain name must not start or end with a dot."
  }
}

variable "redirect_hostname" {
  description = "The hostname to redirect traffic to."
  type        = string
}

variable "redirect_protocol" {
  description = "The protocol to use for redirects"
  type        = string
  default     = "https"

  validation {
    condition     = contains(["http", "https"], var.redirect_protocol)
    error_message = "Protocol must be either 'http' or 'https'."
  }
}

variable "cloudfront_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"

  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.cloudfront_price_class)
    error_message = "Must be a valid CloudFront price class."
  }
}

variable "comment" {
  description = "Comment for the CloudFront distribution"
  type        = string
  default     = null
}

variable "subdomains" {
  description = "Optional list of subdomains to create alias records for (e.g., ['www', 'app'])"
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for subdomain in var.subdomains : 
      can(regex("^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$", subdomain))
    ])
    error_message = "Subdomains must be valid DNS labels (alphanumeric and hyphens, max 63 chars)."
  }
}