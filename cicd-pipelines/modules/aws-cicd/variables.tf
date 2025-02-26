variable "branch" {
  description = "GitHub Branch name"
  type        = string
}

variable "repository_name" {
  description = "GitHub Repository name"
  type        = string
}

variable "organization_name" {
  description = "GitHub Organization name"
  type        = string
}

variable "codebuild_project_name" {
  description = "CodeBuild Project name"
  type        = string
}

variable "codepipeline_name" {
    description = "CodePipeline name"
    type        = string
}

variable "s3_bucket_name_artifacts" {
    description = "S3 Bucket name for storing Artifacts"
    type        = string
}