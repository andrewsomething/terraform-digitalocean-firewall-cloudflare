data "cloudflare_ip_ranges" "cloudflare" {}
resource "digitalocean_firewall" "inbound_cloudflare" {
  name = "${var.name}"

  droplet_ids = ["${var.droplet_ids}"]
  tags = ["${var.tags}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = [
        "${data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks}",
        "${data.cloudflare_ip_ranges.cloudflare.ipv6_cidr_blocks}"
      ]
    },
    {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = [
        "${data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks}",
        "${data.cloudflare_ip_ranges.cloudflare.ipv6_cidr_blocks}"
      ]
    },
  ]
}