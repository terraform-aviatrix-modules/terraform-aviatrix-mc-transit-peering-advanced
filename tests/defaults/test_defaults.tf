terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
    aviatrix = {
      source = "aviatrixsystems/aviatrix"
    }
  }
}

module "main" {
  source = "../.."

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

  create_peerings = false
}

module "pruned" {
  source = "../.."

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

  #Prune 1-5 + 3-4
  prune_list = [
    { "gw5" : "gw1" }, #Reverse order
    { "gw3" : "gw4" }, #Ascending order
  ]

  create_peerings = false
}

locals {
  expected_map = {
    "gw1_gw4" = {
      "set1_as" = [
        65001,
      ]
      "set1_name" = "gw1"
      "set2_as" = [
        65004,
      ]
      "set2_name" = "gw4"
    }
    "gw1_gw5" = {
      "set1_as" = [
        65001,
      ]
      "set1_name" = "gw1"
      "set2_as" = [
        65005,
      ]
      "set2_name" = "gw5"
    }
    "gw1_gw6" = {
      "set1_as" = [
        65001,
      ]
      "set1_name" = "gw1"
      "set2_as" = [
        65006,
      ]
      "set2_name" = "gw6"
    }
    "gw2_gw4" = {
      "set1_as" = [
        65002,
      ]
      "set1_name" = "gw2"
      "set2_as" = [
        65004,
      ]
      "set2_name" = "gw4"
    }
    "gw2_gw5" = {
      "set1_as" = [
        65002,
      ]
      "set1_name" = "gw2"
      "set2_as" = [
        65005,
      ]
      "set2_name" = "gw5"
    }
    "gw2_gw6" = {
      "set1_as" = [
        65002,
      ]
      "set1_name" = "gw2"
      "set2_as" = [
        65006,
      ]
      "set2_name" = "gw6"
    }
    "gw3_gw4" = {
      "set1_as" = [
        65003,
      ]
      "set1_name" = "gw3"
      "set2_as" = [
        65004,
      ]
      "set2_name" = "gw4"
    }
    "gw3_gw5" = {
      "set1_as" = [
        65003,
      ]
      "set1_name" = "gw3"
      "set2_as" = [
        65005,
      ]
      "set2_name" = "gw5"
    }
    "gw3_gw6" = {
      "set1_as" = [
        65003,
      ]
      "set1_name" = "gw3"
      "set2_as" = [
        65006,
      ]
      "set2_name" = "gw6"
    }
  }

  pruned_map = {
    "gw1_gw4" = {
      "set1_as" = [
        65001,
      ]
      "set1_name" = "gw1"
      "set2_as" = [
        65004,
      ]
      "set2_name" = "gw4"
    }
    # "gw1_gw5" = {
    #   "set1_as" = [
    #     65001,
    #   ]
    #   "set1_name" = "gw1"
    #   "set2_as" = [
    #     65005,
    #   ]
    #   "set2_name" = "gw5"
    # }
    "gw1_gw6" = {
      "set1_as" = [
        65001,
      ]
      "set1_name" = "gw1"
      "set2_as" = [
        65006,
      ]
      "set2_name" = "gw6"
    }
    "gw2_gw4" = {
      "set1_as" = [
        65002,
      ]
      "set1_name" = "gw2"
      "set2_as" = [
        65004,
      ]
      "set2_name" = "gw4"
    }
    "gw2_gw5" = {
      "set1_as" = [
        65002,
      ]
      "set1_name" = "gw2"
      "set2_as" = [
        65005,
      ]
      "set2_name" = "gw5"
    }
    "gw2_gw6" = {
      "set1_as" = [
        65002,
      ]
      "set1_name" = "gw2"
      "set2_as" = [
        65006,
      ]
      "set2_name" = "gw6"
    }
    # "gw3_gw4" = {
    #   "set1_as" = [
    #     65003,
    #   ]
    #   "set1_name" = "gw3"
    #   "set2_as" = [
    #     65004,
    #   ]
    #   "set2_name" = "gw4"
    # }
    "gw3_gw5" = {
      "set1_as" = [
        65003,
      ]
      "set1_name" = "gw3"
      "set2_as" = [
        65005,
      ]
      "set2_name" = "gw5"
    }
    "gw3_gw6" = {
      "set1_as" = [
        65003,
      ]
      "set1_name" = "gw3"
      "set2_as" = [
        65006,
      ]
      "set2_name" = "gw6"
    }
  }
}

resource "test_assertions" "peerings_map" {
  component = "peerings_map"

  equal "maps" {
    description = "Module output is equal to check map."
    got         = module.main.peerings
    want        = local.expected_map
  }
}

resource "test_assertions" "peerings_map_pruned" {
  component = "peerings_map_pruned"

  equal "maps_pruned" {
    description = "Module output is equal to check map."
    got         = module.pruned.peerings
    want        = local.pruned_map
  }
}
