#CodeBuild
resource "aws_codebuild_project" "codebuild_project" {
  name          = var.codebuild_name
  description   = "CodeBuild project"
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = 40

  source {
    type      = var.source_type
    buildspec = file(var.codebuild_commands_path)
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "296124192070.dkr.ecr.eu-west-1.amazonaws.com/ci-cd-pipeline-tools-installation:v1"
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

#CodeBuild Role
resource "aws_iam_role" "codebuild_role" {
  name = "${var.codebuild_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy" "codebuild_policy" {
  name        = "${var.codebuild_name}-policy"
  description = "Policy for CodeBuild access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetAuthorizationToken",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:BatchGetImage",
          "logs:CreateLogStream"
        ],
        Resource = ["arn:aws:ecr:eu-west-1:296124192070:repository/ci-cd-pipeline-tools-installation*"],
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role       = aws_iam_role.codebuild_role.name
}
