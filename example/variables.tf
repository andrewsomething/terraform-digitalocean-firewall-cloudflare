variable "cloudflare_email" {}
variable "cloudflare_token" {}
variable "cloudflare_domain" {}
variable "cloudflare_zone_id" {}

variable "do_token" {}

variable "do_image" {
  default = "lemp-18-04"
}

variable "do_region" {
  default = "nyc3"
}

variable "do_size" {
  default = "512mb"
}

variable "test_name" {
  default = "tf-example"
}
