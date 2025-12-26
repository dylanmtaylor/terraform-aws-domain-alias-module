###############################################################################
#### S3 Bucket for Static Site Hosting (Redirects)
#### This bucket contains only objects with metadata to enable a redirect.
###############################################################################

resource "aws_s3_bucket" "redirect_bucket" {
  bucket_prefix = local.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "redirect_bucket" {
  bucket = aws_s3_bucket.redirect_bucket.bucket
  
  redirect_all_requests_to {
    protocol  = var.redirect_protocol
    host_name = var.redirect_hostname
  }
}

resource "aws_s3_bucket_public_access_block" "redirect_bucket" {
  bucket = aws_s3_bucket.redirect_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}