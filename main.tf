module "app1" {
  source = "./apps/first_app"

  application = "app1"
  environment = "dev"
  owner       = "kacper@szczepanek.dev"
  prefix      = "ks"
}

module "app2" {
  source = "./apps/second_app"

  application = "app2"
  environment = "dev"
  owner       = "kacper-but-other@szczepanek.dev"
  prefix      = "ks"
}

module "app3" {
  source = "./apps/third_app"

  application = "app3"
  environment = "dev"
  owner       = "kacper-but-admin@szczepanek.dev"
  prefix      = "ks"
}
