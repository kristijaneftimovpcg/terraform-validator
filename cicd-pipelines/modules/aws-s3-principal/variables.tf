variable "bucket_name" {
  description = "The S3 bucket name for storing Artifacts"
  type        = string
}

variable "enable_acl" {
  description = "Enable ACL"
  type        = bool
  default     = true
}

variable "principal_role_arn" {
  description = "The ARN role for principal"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}