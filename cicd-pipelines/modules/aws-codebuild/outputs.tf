output "codebuild_project_arn" {
  value       = aws_codebuild_project.codebuild_project.arn
  description = "CodeBuild Project ARN"
}

output "codebuild_project_name" {
  value       = aws_codebuild_project.codebuild_project.name
  description = "CodeBuild Project name"
}

output "codebuild_role" {
  value       = aws_iam_role.codebuild_role
  description = "CodeBuild Role"
}
