variable "cloud_id" {
  description = "Yandex Cloud ID."
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID."
  type        = string
}

variable "zone" {
  description = "Yandex Cloud availability zone."
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network."
  type        = string
  default     = "kittygram-network"
}

variable "subnet_name" {
  description = "Name of the VPC subnet."
  type        = string
  default     = "kittygram-subnet"
}

variable "subnet_cidr" {
  description = "IPv4 CIDR block for the subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "security_group_name" {
  description = "Name of the security group."
  type        = string
  default     = "kittygram-security-group"
}

variable "vm_name" {
  description = "Name of the Compute Cloud instance."
  type        = string
  default     = "kittygram-vm"
}

variable "image_family" {
  description = "Yandex Cloud image family for the VM boot disk."
  type        = string
  default     = "ubuntu-2404-lts"
}

variable "vm_cores" {
  description = "Number of vCPU cores for the VM."
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "RAM size in GB for the VM."
  type        = number
  default     = 2
}

variable "vm_core_fraction" {
  description = "Baseline performance for shared-core VM."
  type        = number
  default     = 20
}

variable "disk_size" {
  description = "Boot disk size in GB."
  type        = number
  default     = 20
}

variable "ssh_user" {
  description = "Linux user created by cloud-init."
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key for the VM user."
  type        = string
  sensitive   = true
}

variable "gateway_port" {
  description = "External port used by the gateway service."
  type        = number
  default     = 8000
}

variable "ssh_allowed_cidrs" {
  description = "CIDR blocks allowed to connect to SSH."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "gateway_allowed_cidrs" {
  description = "CIDR blocks allowed to connect to Kittygram gateway."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_bucket_name" {
  description = "Name of the application Object Storage bucket."
  type        = string
}
