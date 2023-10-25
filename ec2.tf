resource "aws_instance" "bitgouel-main-server" {
  ami = "ami-04cebc8d6c4f297a3"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.bitgouel-private-subnet-2a.id
  vpc_security_group_ids = [aws_security_group.bitgouel-main-server-sg.id]
  key_name = "bitgouel-key"
  associate_public_ip_address = false
  source_dest_check = false

  tags = {
    Name = "bitgouel-main-server"
  }

}

