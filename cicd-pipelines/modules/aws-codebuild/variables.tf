variable "codebuild_commands_path" {
  description = "CodeBuild Commands file path"
  type        = string
}

variable "source_type" {
  description = "Source type"
  type        = string
}

variable "artifacts_type" {
  description = "Artifacts type"
  type        = string
}

variable "codebuild_name" {
  description = "CodeBuild name"
  type        = string
}

variable "codebuild_config_role" {
  description = "The CodeBuild default role"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
