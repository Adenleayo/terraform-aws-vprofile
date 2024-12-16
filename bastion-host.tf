resource "aws_instance" "dove-web" {
  ami                    = lookup(var.AMIS, var.REGION)
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = aws_key_pair.vprofilekey.key_name
  vpc_security_group_ids = [aws_security_group.vprofile-bastion-sg.id]
  count = var.instance_count

  tags = {
    Name        = "dove-instance"
    Project     = "Dove"
    Environment = "Production"
  }

  provisioner "file" {
    content      = templatefile("template/db-deploy.tmpl, { rds-endpoint = aws_db_instance.vprofile-rds-instance.address, dbuser = var.dbuser, dbpass = var.dbpass}")
    destination = "/tmp/vprofile-deploy.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-deploy.sh",
      "sudo /tmp/vprofile-deploy.sh"
    ]

  }


   connection {
    user        = var.username
    private_key = file(var.pvt_key)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.vprofile-rds-instance]

}