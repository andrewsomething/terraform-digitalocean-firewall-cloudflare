terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

data "http" "cloudflare_ip4_addrs" {
  url = "https://www.cloudflare.com/ips-v4"
}

data "http" "cloudflare_ip6_addrs" {
  url = "https://www.cloudflare.com/ips-v6"
}

resource "digitalocean_firewall" "inbound_cloudflare" {
  name = var.name

  droplet_ids = var.droplet_ids
  tags        = var.tags

  inbound_rule {
      protocol   = "tcp"
      port_range = "80"
      source_addresses = concat(
        split("\n", trimspace(data.http.cloudflare_ip4_addrs.body)),
        split("\n", trimspace(data.http.cloudflare_ip6_addrs.body))
      )
  }
  
  inbound_rule {
      protocol   = "tcp"
      port_range = "443"
      source_addresses = concat(
        split("\n", trimspace(data.http.cloudflare_ip4_addrs.body)),
        split("\n", trimspace(data.http.cloudflare_ip6_addrs.body))
      )
  }
}
