resource "tls_private_key" "bitgouel-make-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bitgouel-key-pair" {
  key_name   = "bitgouel-key"
  public_key = tls_private_key.bitgouel-make-key.public_key_openssh
}

resource "local_file" "bitgouel-download-key" {
  filename = "bitgouel-key.pem"
  content  = tls_private_key.bitgouel-make-key.private_key_pem
}