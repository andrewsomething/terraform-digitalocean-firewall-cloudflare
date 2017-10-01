# End to end example

This example will create the following resources:

- 1 DigitalOcean Droplet 
- 1 Cloudflare A record named
- 1 DigitalOcean Firewall

It requires the following input variables:

- `cloudflare_email`  - Your Cloudflare login email.
- `cloudflare_token`  - Your Cloudflare API token.
- `do_token`          - Your DigitalOcean API token.
- `cloudflare_domain` - The Cloudflare domain to which the A record will be added.
- `test_name` - The name that will be used for both the A record and the Droplet. (Default: `tf-example`)

You can run this example with:

```
terraform init
terraform plan -var "do_token=$DO_TOKEN" -var "cloudflare_email=$CF_EMAIL" -var "cloudflare_token=$CF_TOKEN" -var "cloudflare_domain=$CF_DOMAIN"
terraform apply -var "do_token=$DO_TOKEN" -var "cloudflare_email=$CF_EMAIL" -var "cloudflare_token=$CF_TOKEN" -var "cloudflare_domain=$CF_DOMAIN"
```