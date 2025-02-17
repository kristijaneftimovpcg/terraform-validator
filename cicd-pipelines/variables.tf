variable "profile" {
  description = "AWS profile"
  type        = string
  default     = "playground"
}

variable "region" {
  description = "The AWS region"
  default     = "eu-west-1"
  type        = string
}

variable "branch" {
  description = "The source branch"
  default     = "main"
  type        = string
}

variable "codebuild_name" {
  description = "CodeBuild name"
  type        = string
  default     = "terraform-validator-codebuild"
}

variable "codepipeline_name" {
  description = "CodePipeline Name"
  type        = string
  default     = "terraform-validator-pipeline"
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name for storing Artifacts"
  default     = "terraform-validator-artifacts-bucket"
  type        = string
}

variable "repository_name" {
  description = "Github Repository Name"
  default     = "terraform-validator"
  type        = string
}

variable "organization_name" {
  description = "Github Organization Name"
  default     = "kristijaneftimovpcg"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
