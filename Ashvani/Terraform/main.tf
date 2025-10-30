module "rg" {
  source = "./RG"
  rg = var.rg
}
module "storage" {
  source = "./storage_ac"
  depends_on = [ module.rg ]
  storage = var.storage
}
module "vnet" {
  source = "./vnet"
  depends_on = [ module.rg ]
  vnet = var.vnet
}
