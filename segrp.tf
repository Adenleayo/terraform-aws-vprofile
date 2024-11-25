resource "aws_security_group" "vprofile-bean-elb-sg" {
    name        = "vprofile-bean-elb-sg"
    description = "security group for bean elb security group"
    vpc_id      = module.vpc.vpc_id
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_seurity_group" "vprofile-bastion-sg" {
    name        = "vprofile-bastion-sg"
    description = "security group for bastion host security group"
    vpc_id      = module.vpc.vpc_id
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.myip]
    }

}

recource "aws_secrity_group" "vprofile-prod-sg" {
    name        = "vprofile-prod-sg"
    description = "security group for production environment"
    vpc_id      = module.vpc.vpc_id
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [aws_secrity_group.vprofile_bastion-sg.id]
    }
}

resource "aws_secrity_group" "vprofile_backend_sg" {
    name        = "vprofile-backend-sg"
    description = "security group for backend"
    vpc_id      = module.vpc.vpc_id
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [aws_secrity_group.vprofiile-prod-sg.id]
    }


}

resource "aws_security_group_rule" "sec_group_allow_itself" {
    security_group_id = aws_security_group.vprofile_backend_sg.id
    source_security_group_id = aws_security_group.vprofile_backend_sg.id
    type              = "ingress"
    from_port         = 0
    to_port           = 65535
    protocol          = "tcp"

}

