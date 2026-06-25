output "instance_public_ip" {
  description = "Public IPv4 address of the Kittygram VM."
  value       = yandex_compute_instance.kittygram.network_interface[0].nat_ip_address
}

output "kittygram_url" {
  description = "HTTP URL for the deployed Kittygram application."
  value       = "http://${yandex_compute_instance.kittygram.network_interface[0].nat_ip_address}:${var.gateway_port}"
}

output "app_bucket_name" {
  description = "Object Storage bucket created for the application."
  value       = yandex_storage_bucket.kittygram.bucket
}
