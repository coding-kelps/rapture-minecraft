output "ansible_vars" {
  value = jsonencode(yamldecode(
    templatefile("templates/ansible_vars.yml.tftpl", {
      server_public_ip = aws_instance.minecraft_server.public_ip,
    })
  ))
  sensitive = false
  description = "Output Ansible variables"
}