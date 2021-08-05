variable "set1" {
  type        = map(object)
  description = "Map object of transit gateway names and asn's to create full mesh peering from"
}

variable "set2" {
  type        = map(object)
  description = "Map object of transit gateway names and asn's to create full mesh peering from"
}

variable "enable_peering_over_private_network" {
  type        = bool
  description = "Enable to use a private circuit for setting up peering"
  default     = false
}

variable "excluded_cidrs" {
  type        = list(string)
  description = "A list of CIDR's to exclude on the peers"
  default     = []
}

variable "enable_single_tunnel_mode" {
  type        = bool
  description = "Enable single tunnel mode."
  default     = false
}

variable "enable_insane_mode_encryption_over_internet" {
  type        = bool
  description = "Enable insane mode over internet"
  default     = null
}

variable "tunnel_count" {
  type        = number
  description = "Amount of tunnels to build for insane mode over internet"
  default     = null
}