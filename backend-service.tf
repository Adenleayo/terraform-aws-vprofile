resource "aws_db_subnet_group" "vprofile-rds-subgroups" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_elasticache_subnet_group" "vprofile-ecache-subgroups" {
  name       = "vprofile-ecache-subgroups"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    Name = "My elasticache subnet group"
  }
}

resource "aws_db_instance" "vprofile-rds-instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.39"
  instance_class         = "db.t2.micro"
  multi_az               = "false"
  publicly_accessible    = true
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.vprofile-rds-subgroups.name
  vpc_security_group_ids = [aws_security_group.vprofile_backend_sg.id]
}



resource "aws_elasticache_cluster" "vprofile-cache" {
  cluster_id           = "vprofile-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.4"
  port                 = 11211
  security_group_ids   = [aws_security_group.vprofile_backend_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.vprofile-ecache-subgroups.name
}

resource "aws_mq_broker" "vprofile-rmq" {
  broker_name = "vprofile-rmq"


  engine_type        = "ActiveMQ"
  engine_version     = "5.17.6"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.vprofile_backend_sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]
  user {
    username = var.rmquser
    password = var.rmqpass
  }
}