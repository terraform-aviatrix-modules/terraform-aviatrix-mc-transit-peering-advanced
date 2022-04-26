variable "set1" {
  type        = map(any)
  description = "Map object of transit gateway names and asn's to create full mesh peering from"
}

variable "set2" {
  type        = map(any)
  description = "Map object of transit gateway names and asn's to create full mesh peering from"
}

variable "enable_peering_over_private_network" {
  type        = bool
  description = "Enable to use a private circuit for setting up peering"
  default     = false
  nullable    = false
}

variable "excluded_cidrs" {
  type        = list(string)
  description = "A list of CIDR's to exclude on the peers"
  default     = []
  nullable    = false
}

variable "enable_single_tunnel_mode" {
  type        = bool
  description = "Enable single tunnel mode."
  default     = false
  nullable    = false
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

variable "prepend_length" {
  type        = number
  description = "Amount of times AS Path is prepended"
  default     = 1
  nullable    = false
}

variable "as_path_prepend" {
  type        = bool
  description = "Toggle to true to enable AS Path prepending for all peers"
  default     = false
  nullable    = false
}

variable "create_peerings" {
  type        = bool
  description = "Toggle for setting peering resource creation on or off. When set to false, it only generates the peerings output."
  default     = true
  nullable    = false
}

variable "prune_list" {
  type     = list(map(string))
  default  = []
  nullable = false
}
