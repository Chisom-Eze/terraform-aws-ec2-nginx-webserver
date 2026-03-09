variable "aws_region" {
  description = "us-east-1"
  type        = string
}

variable "instance_type" {
  description = "t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "my_ip" {
  description = "102.90.115.206/32"
}