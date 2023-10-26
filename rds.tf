
## DB Subnet Group Setting

resource "aws_db_subnet_group" "bitgouel-subnet-group" {
    name = "bitgouel-subnet-group"
    subnet_ids = [
        aws_subnet.bitgouel-public-subnet-2a.id,
        aws_subnet.bitgouel-public-subnet-2b.id
    ]
}

## Create DB SG
resource "aws_security_group" "bitgouel-rds-sg" {
    name = "bitgouel-rds-sg"
    vpc_id = aws_vpc.bitgouel-vpc.id

    ingress{
        description = "Allow MySQL traffic from only the sms-main-server instance."
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bitgouel-rds-sg"
    }
}

## Create DB_MYSQL
resource "aws_db_instance" "bitgouel-backend-database" {
    allocated_storage    = 20
  max_allocated_storage = 50
  availability_zone    = "ap-northeast-2a"
  db_subnet_group_name = aws_db_subnet_group.bitgouel-subnet-group.id
  vpc_security_group_ids = [aws_security_group.bitgouel-rds-sg.id]
  engine               = "mysql"
  engine_version       = "8.0.32"
  instance_class       = "db.t3.micro"
  skip_final_snapshot  = true
  publicly_accessible  = true
  identifier           = "bitgouel-mysql"
  username             = var.user_name
  password             = var.db_password
  port                 = "3306"
}

## Create DB_Redis