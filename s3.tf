resource "aws_s3_bucket" "bitgouel-file_bucket" {
    bucket = "bitgouel-file-bucket"
    acl = "private"

    tag = {
        name = "bitgouel-file-bucket"
    }
}