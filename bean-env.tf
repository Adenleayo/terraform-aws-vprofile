resource "aws_elastic_beanstalk_environment" "vprofile-bean-prod" {
  name                = "vprofile-bean-prod"
  application         = aws_elastic_beanstalk_application.vprofile-bean-prod.name
  solution_stack_name = "64bit Amazon Linux 2023 v5.4.1 running Tomcat 9 Corretto 11"
  cname_prefix = "vprofile-bean-prod-domain"
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",",[module.vpc.private_subnets[0],module.vpc.private_subnets[1],module.vpc.private_subnets[2]])
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",",[module.vpc.private_subnets[0],module.vpc.private_subnets[1],module.vpc.private_subnets[2]])
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize" 
    value     = "4"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName" 
    value     = aws_key_pair.vprofilekey.key_name
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize" 
    value     = "1"
  }

  setting {
    namespace= "aws:autoscaling:asg"
    name = "AvailabilityZone"
    value = join(",",[var.ZONE1,var.ZONE2,var.ZONE3])
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "Environment"
    value     = "production"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "LOGGING_APPENDER"
    value = "GRAYLOG"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "basic"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "HealthReportingSystemType"
    value = "Health"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MaxBatchSize"
    value = "1"
  }

  setting {
    namespace = "ws:elb:loadbalancer"
    name = "CrossZone"
    value = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSizeType"
    value = "Fixed"
  }

  setting {
    namespace = "ws:elasticbeanstalk:environment:process:default"
    name = "SticknessEnabled"
    value = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "1"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "DeploymentPolicy"
    value = "Rolling"
  }

  setting {
    namespace = "aws:elasticbeanstalk:launchconfiguration"
    name = "securityGroup"
    value = aws_security_group.vprofile-prod-sg.id
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "SecurityGroups"
    value = aws_security_group.vprofile-bean-elb-sg.id
  }


  #beanstalk security and the production securitymust be created before the beanstalk environment
  depends_on = [aws_security_group.vprofile-bean-elb-sg,aws_security_group.vprofile-prod-sg]
  

}