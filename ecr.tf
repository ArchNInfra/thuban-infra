resource "aws_ecr_repository" "alphard_inference" {
    name                 = "alphard-inference"
    image_tag_mutability = "IMMUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }

    tags = {
        Projecct = "constellation"
        Owner    = "Shane"
        Role     = "inference"
    }
}

output "alphard_ecr_repository_url" {
    value = aws_ecr_repository.alphard_inference.repository_url
}