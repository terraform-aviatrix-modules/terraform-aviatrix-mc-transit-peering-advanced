# terraform-aviatrix-mc-transit-peering-advanced

### Description
This module will create a full mesh transit between all gateways from one map to all gateways from a second map and allows for additional attributes to be configured.
This module is aimed a the use case where you want to build transit peerings between different cloud platforms and want to use other attributes, like for example AS path prepending.

### Diagram
\<Provide a diagram of the high level constructs that will be created by this module>
<img src="<IMG URL>"  height="250">

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.0.0 | 0.13-1.0.1 | >=6.4 | >=0.2.19

### Usage Example
```
module "transit_aws_1" {
  source  = "terraform-aviatrix-modules/mc-transit-peering-advanced/aviatrix"
  version = "1.0.0"

  set1 = {
      "gw1" = 65001
      "gw2" = 65002
      "gw3" = 65003
  }

  set2 = {
      "gw4" = 65004
      "gw5" = 65005
      "gw6" = 65006
  }  

  excluded_cidrs = [
    0.0.0.0/0,
  ]
}
```

### Variables
The following variables are required:

key | value
:--- | :---
set1 | map of transit gateways and ASN
set2 | map of transit gateways and ASN

key | default | value 
:---|:---|:---
as_path_prepend | false | Toggle to true to enable AS Path prepending for all peerings
prepend_length | 1 | Amount of times AS Path is prepended
enable_peering_over_private_network | false | Enable to use a private circuit for setting up peering
excluded_cidrs | [] | list of excluded cidrs. This will be applied to all peerings on both sides. If you need more granularity, it is suggested to use the aviatrix_transit_gateway_peering resource directly in stead of this module.
enable_single_tunnel_mode | false | Enable single tunnel mode. Will be applied to all peerings. If you need more granularity, it is suggested to use the aviatrix_transit_gateway_peering resource directly in stead of this module.
enable_insane_mode_encryption_over_internet | false | Enable insane mode over internet. Will be applied to all peerings. If you need more granularity, it is suggested to use the aviatrix_transit_gateway_peering resource directly in stead of this module.
tunnel_count | | Amount of tunnels to build for insane mode over internet. Will be applied to all peerings. If you need more granularity, it is suggested to use the aviatrix_transit_gateway_peering resource directly in stead of this module.

### Outputs
This module will return the following outputs:

key | description
:---|:---
\<keyname> | \<description of object that will be returned in this output>
