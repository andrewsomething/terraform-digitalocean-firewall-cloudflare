provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}

provider "digitalocean" {
  token = "${var.do_token}"
}

module "firewall_inbound_cloudflare" {
  source = "andrewsomething/firewall-cloudflare/digitalocean"

  name          = "inbound-cloudflare-firewall"
  droplet_ids   = ["${digitalocean_droplet.tf-example.id}"]
}

resource "cloudflare_record" "foobar" {
  domain  = "${var.cloudflare_domain}"
  name    = "${var.test_name}"
  value   = "${digitalocean_droplet.tf-example.ipv4_address}"
  type    = "A"
  proxied = true
}

resource "digitalocean_droplet" "tf-example" {
  image  = "${var.do_image}"
  name   = "${var.test_name}.${var.cloudflare_domain}"
  region = "${var.do_region}"
  size   = "${var.do_size}"
}
