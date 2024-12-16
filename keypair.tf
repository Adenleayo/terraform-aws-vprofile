resource "aws_key_pair" "vprofilekey" {
  key_name   = "vprofile-keypair"
  public_key = file(var.pub-key)
}

