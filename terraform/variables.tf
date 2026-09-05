variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.large"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "EC2 SSH key pair name"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Existing public subnet ID"
  type        = string
  default     = ""
}
