module "app1_to_app2_vnet_peering" {
  source           = "./modules/vnet_peering"
  is_bidirectional = true

  first_prefix              = module.app1.prefix
  first_resource_group_name = module.app1.resource_group_name
  first_vnet_name           = module.app1.vnet_name
  first_vnet_id             = module.app1.vnet_id
  first_application         = module.app1.application
  first_environment         = module.app1.environment

  second_prefix              = module.app2.prefix
  second_resource_group_name = module.app2.resource_group_name
  second_vnet_name           = module.app2.vnet_name
  second_vnet_id             = module.app2.vnet_id
  second_application         = module.app2.application
  second_environment         = module.app2.environment
}

module "app1_to_app3_vnet_peering" {
  source           = "./modules/vnet_peering"
  is_bidirectional = true

  first_prefix              = module.app1.prefix
  first_resource_group_name = module.app1.resource_group_name
  first_vnet_name           = module.app1.vnet_name
  first_vnet_id             = module.app1.vnet_id
  first_application         = module.app1.application
  first_environment         = module.app1.environment

  second_prefix              = module.app3.prefix
  second_resource_group_name = module.app3.resource_group_name
  second_vnet_name           = module.app3.vnet_name
  second_vnet_id             = module.app3.vnet_id
  second_application         = module.app3.application
  second_environment         = module.app3.environment
}
