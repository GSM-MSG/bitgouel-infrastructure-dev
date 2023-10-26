resource "aws_s3_bucket" "bitgouel-file_bucket" {
    bucket = "bitgouel-file-bucket"
    aws_bucket_s3_acl = "private"

    tags = {
        name = "bitgouel-file-bucket"
    }
}