variable "region" { default = "eu-central-1" }
variable "availability_zone" { default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"] }
variable "ami" { default = "ami-04cf43aca3e6f3de3" }
variable "instance_type" { default = "t2.micro" }
variable "instance_count" { default = "2" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "vpc_count" { default = "3" }
variable "db_type" { default = "db.t2.micro" }
variable "db_name" { default = "moodledb" }
variable "db_user_name" { default = "moodleuser" }
variable "db_pass" { default = "passworddb" }