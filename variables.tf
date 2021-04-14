
data "template_file" "user_data" {
  template = file("${path.module}/files/templates/user-data.sh")
  vars = {
    password = random_password.password.result
  }
}


locals {
  app_name           = "MEDIAWIKI"
  pub_sub_cidr_1     = "10.0.0.0/18"
  pub_sub_cidr_2     = "10.0.64.0/18"
  pri_sub_cidr_1     = "10.0.128.0/18"
  pri_sub_cidr_2     = "10.0.192.0/18"
  vpc_cidr           = "10.0.0.0/16"
  instance_type      = "t2.micro"
  PATH_TO_PUBLIC_KEY = "./key_pairs/mediawiki.pub"
  identifier         = "db-server"
  master_username    = "db-master-user"
}

