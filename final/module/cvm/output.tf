output "public_ip" {
  description = "public ip address"
  value       = tencentcloud_instance.ubuntu[0].public_ip
}

output "private_ip" {
  description = "private ip address"
  value       = tencentcloud_instance.ubuntu[0].private_ip
}
