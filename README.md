# Terraform Module for DigitalOcean Firewall + Cloudflare

This module allows you to create a DigitalOcean Firewall that only accepts inbound connections from Cloudflare's [published list](https://www.cloudflare.com/ips/) of IP addresses.

### Why would I use this?

Cloudflare provides DDOS protection for domains using its DNS. If an attacker knows the IP address of your origin server, this can easily be circumvented. Using the approach in this module prevents incoming connections to the server from all non-Cloudflare IPs.

This could be done at the server level using `iptables` or other firewall software. Though a missconfigured firewall could prevent you from accessing your server. Using a DigitalOcean Firewall, you can open or close additional ports as needed.

This can also be achieved at the web server level using the `DenyAllButCloudFlare` rule from Cloudflare's [Mod_Cloudflare](https://www.cloudflare.com/technical-resources/#mod_cloudflare) Apache extension or similar tools for Nginx. Though this still uses bandwidth and system resources on the origin server. Using a DigitalOcean Firewall means the un-wanted traffic will be blocked before it ever reaches you.

Cloudflare IP addresses may also change. Tracking those changes and applying them by hand in the DigitalOcean control panel can be tedious. Using this module, re-running `terraform apply` will pick up those changes and reconfigure your Firewall.

## Module input variables

- `name` - The name of the firewall to be created.
- `droplet_ids` - A list of the IDs of the Droplets assigned to the Firewall.
- `tags` - A list of tag names assigned to the Firewall.

## Example

This example creates a Firewall and a tag named `allow_inbound_cloudflare`. Any Droplet with this tag applied to it will only allow inbound connections to ports 80 and 443 from Cloudflare IPs.

```tf
module "firewall_inbound_cloudflare" {
  source = "andrewsomething/firewall-cloudflare/digitalocean"

  name   = "inbound-cloudflare"
  tags   = ["allow_inbound_cloudflare"]
}

resource "digitalocean_tag" "allow_inbound_cloudflare" {
  name = "allow_inbound_cloudflare"
}
```

**Note:** DigitalOcean Firewalls are composable. Creating separate Firewalls for separate concerns is considered a best practice. When using the above example, additional Firewalls should be applied to the Droplets in order to allow for things like inbound SSH access and outbound DNS lookups.

## License

MIT licensed. See LICENSE for full details.
