# AWS Domain Alias Module

A reusable Terraform module to handle domain redirects using S3 website redirects, Cloudflare and ACM. This is a pattern that was used at a previous employer to handle domain redirects that I just re-implemented from memory because of a need to handle a similar situation again. Because this is a common pattern that might be useful to many people, I'm making this module I wrote open source. This comes with absolutely no guarantee of support or any warranty of any kind, but feel free to use this for your projects.

**NOTE**: It is necessary to deploy this to the *us-east-1* region in order to create the Cloudfront distributions and ACM certificates correctly.
