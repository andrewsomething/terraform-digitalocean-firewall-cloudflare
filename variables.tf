variable "name" {
  type        = "string"
  default     = "inbound-cloudflare"
  description = "The name of the firewall to be created."
}

variable "droplet_ids" {
  type        = "list"
  default     = []
  description = "The list of the IDs of the Droplets assigned to the Firewall."
}

variable "tags" {
  type        = "list"
  default     = []
  description = "The list of Tag names assigned to the Firewall."
}
