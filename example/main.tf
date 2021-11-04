terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_token
}

provider "digitalocean" {
  token = var.do_token
}

module "firewall_inbound_cloudflare" {
  source = "andrewsomething/firewall-cloudflare/digitalocean"

  name        = "inbound-cloudflare-firewall"
  droplet_ids = [digitalocean_droplet.tf-example.id]
}

resource "cloudflare_record" "foobar" {
  zone_id  = var.cloudflare_zone_id
  name     = var.test_name
  value    = digitalocean_droplet.tf-example.ipv4_address
  type     = "A"
  proxied  = true
}

resource "digitalocean_droplet" "tf-example" {
  image  = var.do_image
  name   = format("%s.%s", var.test_name, var.cloudflare_domain)
  region = var.do_region
  size   = var.do_size
}
