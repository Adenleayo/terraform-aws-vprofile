variable "REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0866a3c8686eaeeba"
    us-east-2 = "ami-050cd642fd83388e4"
  }
}
variable "pub-key" {
  default = "vprofile-key.pub"
}

variable "pvt_key" {
  default = "vprofile-key"
}

variable "username" {
  default = "ubuntu"
}

variable "myip" {
  default = "102.88.111.103"
}

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "pastorbadboy@1"
}

variable "dbname" {
  default = "Accounts"

}

variable "dbpass" {
  default = "admin123"

}

variable "dbuser" {
  default = "admin"

}

variable "instance_count" {
  default = "1"

}

variable "vpc_name" {
  default = "vprofile-vpc"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "ZONE4" {
  default = "us-east-1d"
}

variable "vpcCIDR" {
  default = "172.21.0.0/16"
}

variable "pubsub1CIDR" {
  default = "172.21.1.0/24"
}

variable "pubsub2CIDR" {
  default = "172.21.2.0/24"
}

variable "pubsub3CIDR" {
  default = "172.21.3.0/24"
}

variable "pubsub4CIDR" {
  default = "172.21.4.0/24"
}

variable "privsub1CIDR" {
  default = "172.21.5.0/24"
}

variable "privsub2CIDR" {
  default = "172.21.6.0/24"
}

variable "privsub3CIDR" {
  default = "172.21.7.0/24"
}

variable "privsub4CIDR" {
  default = "172.21.8.0/24"
}