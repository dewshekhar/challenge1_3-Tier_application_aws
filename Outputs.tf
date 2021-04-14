output "Conection_Strings" {
  description = "Conection_Strings"
  value       = split(",", "endpoint=${aws_lb.lb.dns_name}/mediawiki, Host=localhost, Username=wiki, Database=wikidatabase, Password=${random_password.password.result}")
}
