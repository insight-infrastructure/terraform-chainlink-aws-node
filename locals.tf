locals {
  instance_family = split(".", var.instance_type)[0]
  instance_size   = split(".", var.instance_type)[1]


  minimum_volume_size = {
    mainnet = 260,
    testnet = 70
  }
  minimum_instance_type = "t3.small"

  instance_store_enabled = contains(["m5d", "m5ad", "m5dn", "r5dn", "r5d", "z1d", "c5d", "c3", "i3", "i3en"], local.instance_family)

  instance_type    = var.minimum_specs ? local.minimum_instance_type : var.instance_type
  root_volume_size = var.minimum_specs ? lookup(local.minimum_volume_size, var.network_name) : var.root_volume_size

  volume_path = "/dev/xvdf"
}
