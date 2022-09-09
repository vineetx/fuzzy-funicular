variable "region" {
  default = "ap-southeast-2"
}

variable "ami_id" {
  default = "ami-a0360bc3"
}

variable "instance_class" {
  default = "m3.medium"
}

variable "key_name" {
  description = "SSH key name to launch instances with"
}

variable "access_key" {
  description = "AWS account access key"
}

variable "secret_key" {
  description = "AWS account secret access key"
}
