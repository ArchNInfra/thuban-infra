resource "aws_s3_bucket" "state_bucket" {
    bucket = "constellation-tf-state-294933866854"

    tags = {
        Name    = "Constellation TF State"
        Project = "Constellation"
        Owner   = "Platform"
        Env     = "mgmt"
    }
}

resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
    bucket = aws_s3_bucket.state_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
    bucket = aws_s3_bucket.state_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_public_access_block" "state_bucket_block" {
    bucket = aws_s3_bucket.state_bucket.id 

    block_public_acls       = true 
    block_public_policy     = true 
    ignore_public_acls      = true 
    restrict_public_buckets = true
}