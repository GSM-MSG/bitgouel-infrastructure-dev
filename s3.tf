resource "aws_s3_bucket" "bitgouel-file_bucket" {
    bucket = "bitgouel-file-bucket"

    tags = {
        name = "bitgouel-file-bucket"
    }
}