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

variable "policy_additional_actions" {
  description = "CodeBuild Role Policy Additional Actions"
  type        = list(string)
}

variable "codebuild_name" {
  description = "CodeBuild Name"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "eks_cb_kubectl_role_arn" {
  type = string
}
