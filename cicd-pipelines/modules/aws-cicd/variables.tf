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
  description = "CodeBuild project name"
  type        = string
}

variable "policy_additional_actions" {
  description = "Role Policy Additional Actions"
  type        = list(string)
}

variable "artifact_bucket" {
  description = "The artifacts bucket"
  default     = "dev-artifact-bucket-pipeline"
  type        = string
}

variable "codepipeline_name" {
    description = "CodePipeline Name"
    type        = string
}

variable "s3_bucket_name" {
    description = "S3 Bucket Name for storing Artifacts"
    type        = string
}