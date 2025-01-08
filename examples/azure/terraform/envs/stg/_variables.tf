variable "project" {
  description = "Name of project"
  type        = string
}
variable "env" {
  description = "Name of project environment"
  type        = string
}
variable "full_env" {
  description = "Full name of project environment"
  type        = string
}
variable "location" {
  description = "Name region of environment"
  type        = string
}
variable "subscription_id" {
  description = "ID of subscription"
  type        = string
}
variable "domain" {
  description = "Domain of environment"
  type        = string
}
variable "global_ips" {
  description = "Whitelist ip identify"
  type        = any
}
variable "vnet" {
  description = "CIDR for vnet"
  type        = any
}
variable "web" {
  description = "Storage for app"
  type        = any
}
