#Core_Infra
module "aws_core_infra" {
  source         = "./modules/aws_core_infra"
  app_name       = local.app_name
  vpc_cidr       = local.vpc_cidr
  pub_sub_cidr_1 = local.pub_sub_cidr_1
  pub_sub_cidr_2 = local.pub_sub_cidr_2
  pri_sub_cidr_1 = local.pri_sub_cidr_1
  pri_sub_cidr_2 = local.pri_sub_cidr_2
}
