variable "ssh_public_key" {
  type = string
  description = "The public SSH key of the machine which will gain authority over the server"
  sensitive = false
  nullable = false
}