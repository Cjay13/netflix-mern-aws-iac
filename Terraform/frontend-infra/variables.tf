variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-2"
}

variable "region-acm" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
  default = "Z0236041Q971BCTPRXPK"
}