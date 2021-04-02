variable "common_tags" {
  type = map(string)
  default = {
    "Description" : "DB Tier",
    "Owner" : "DB Team"
  }
}

variable "aws_region" {
  default = "us-west-2"
}

variable "backend_instance_count" {
  default = 1
}

variable "backend_instance_type" {
  default = "t2.micro"
}

variable "app_url" {
  default = "https://backend-hc-step1.s3-us-west-2.amazonaws.com/backend.tar.gz"
}