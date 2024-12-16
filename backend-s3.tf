terraform {
  backend "s3" {
    bucket = "terra-vprofile-state-proj"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}