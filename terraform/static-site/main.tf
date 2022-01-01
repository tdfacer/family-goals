# variables

variable "app_name" {
  type        = string
  description = "the name of the static site app"
}

variable "bucket_name" {
  type        = string
  description = "the name of the s3 bucket to store the static site in"
}

variable "domain_name" {
  type        = string
  description = "the domain name that should be used to point to the static site"
}

variable "zone_id" {
  type        = string
  description = "the hosted zone id"
}

variable "acm_certificate_arn" {
  type        = string
  description = "the acm certificate that CloudFront should use for the static site"
}

module "static_site" {
  source = "git::https://github.com/tdfacer/terrafacer.git//terraform/modules/static-site?ref=v2.2.3"
  # uncomment to use local module for dev
  # source = "/home/trevor/code/terrafacer/terraform/modules/static-site"

  app_name            = var.app_name
  bucket_name         = var.bucket_name
  domain_name         = var.domain_name
  acm_certificate_arn = var.acm_certificate_arn
  zone_id             = var.zone_id
}
