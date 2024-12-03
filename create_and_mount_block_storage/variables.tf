variable "instance_id" {
  description = "ID of the instance to attach the volume to"
  type        = string
}

variable "ebs_availability_zone" {
  description = "Availability zone of the EBS volume"
  type        = string
  
}

variable "volume_size" {
  description = "Size of the volume in GiB"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "Type of the volume"
  type        = string
  default     = "gp2"
}

variable "mount_point" {
  description = "Mount point of the volume"
  type        = string
  default     = "/data"

}

variable "completion_flag_name" {
  description = "Name of the completion flag file"
  type        = string
  default     = "disk_mounted"

}

variable "tags" {
  description = "Tags to apply to the volume"
  type        = map(string)
  default     = {}

}