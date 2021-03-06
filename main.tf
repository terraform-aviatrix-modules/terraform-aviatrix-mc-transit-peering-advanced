locals {
  set1_data = [
    for name, asn in var.set1 : {
      set1_name = name
      set1_as   = [for i in range(var.prepend_length) : asn]
    }
  ]

  set2_data = [
    for name, asn in var.set2 : {
      set2_name = name
      set2_as   = [for i in range(var.prepend_length) : asn]
    }
  ]

  peerings_map = {
    for entry in setproduct(local.set1_data, local.set2_data) : "${entry[0].set1_name}_${entry[1].set2_name}" => merge(entry[0], entry[1]) if !contains(var.prune_list, tomap({ (entry[0].set1_name) : (entry[1].set2_name) })) && !contains(var.prune_list, tomap({ (entry[1].set2_name) : (entry[0].set1_name) }))
  }

  #Pass the peerings_map or an empty map to the resource, based on var.create_peerings.
  peerings_resources = var.create_peerings ? local.peerings_map : {}
}

resource "aviatrix_transit_gateway_peering" "peering" {
  for_each                                    = local.peerings_resources
  transit_gateway_name1                       = each.value.set1_name
  transit_gateway_name2                       = each.value.set2_name
  prepend_as_path1                            = var.as_path_prepend ? each.value.set1_as : null
  prepend_as_path2                            = var.as_path_prepend ? each.value.set2_as : null
  enable_peering_over_private_network         = var.enable_peering_over_private_network
  gateway1_excluded_network_cidrs             = var.excluded_cidrs
  gateway2_excluded_network_cidrs             = var.excluded_cidrs
  enable_single_tunnel_mode                   = var.enable_single_tunnel_mode
  enable_insane_mode_encryption_over_internet = var.enable_insane_mode_encryption_over_internet
  tunnel_count                                = var.tunnel_count
}

