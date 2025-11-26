variable "aws_region" {
    description = "AWS Region to deploy resources"
    default     = "ap-northeast-1"
}

variable "github_org" {
    description = "GitHub username or org, used for GitHub Actions OIDC"
    default     = "ArchNInfra"
}