resource "aws_codebuild_project" "codebuild_project" {
  name          = "terraform-validator-codebuild-project"
  description   = "CodeBuild project"
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = 40

  source {
    type      = var.source_type
    buildspec = file(var.codebuild_commands_path)
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"
  }

  artifacts {
    type = var.artifacts_type
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  tags = var.tags
}
