resource "aws_instance" "bitgouel-main-server" {
  ami = "ami-04cebc8d6c4f297a3"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.bitgouel-private-subnet-2a.id
  vpc_security_group_ids = [aws_security_group.bitgouel-main-server-sg.id]
  key_name = "bitgouel-key"
  associate_public_ip_address = false
  source_dest_check = false
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = "bitgouel-main-server"
  }

  user_data = <<-EOF
  #!/bin/bash
  echo "Fetching parameter from SSM"
  my_param_value=$(aws ssm get-parameter --name MyParameter --query 'Parameter.Value' --output text)
  echo "Received SSM parameter value: $my_param_value"
  # 이제 SSM 파라미터 값을 사용하여 인스턴스 구성
EOF

}

# SSM Parameters
resource "aws_ssm_parameter" "my_param" {
  name        = "MyParameter"
  type        = "String"
  value       = "MyValue"  # 원하는 값을 입력하세요.
  description = "My SSM parameter description"
}
