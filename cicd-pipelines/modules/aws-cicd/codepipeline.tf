# S3 Artifacts bucket
module "s3_bucket" {
  source             = "../aws-s3-principal"
  bucket_name        = "${var.s3_bucket_name_artifacts}-${var.repository_name}-repo"
  principal_role_arn = aws_iam_role.codepipeline_role.arn
}

# CodeStar Connection
resource "aws_codestarconnections_connection" "github_connection" {
  name          = "${var.repository_name}-github"
  provider_type = "GitHub"
}

# CodePipeline
resource "aws_codepipeline" "codepipeline" {
  name          = "${var.codepipeline_name}-${var.repository_name}-${var.branch}"
  role_arn      = aws_iam_role.codepipeline_role.arn
  pipeline_type = "V1"

  artifact_store {
    location = module.s3_bucket.s3_bucket
    type     = "S3"
  }

  # With CodeStar Connection
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId = "${var.organization_name}/${var.repository_name}"
        BranchName       = var.branch
      }
    }
  }

  stage {
    name = "Build-Stage"

    action {
      name             = "Build-Stage"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      run_order        = 1

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }
}

# CodePipeline Role
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.codebuild_project_name}-codepipeline-${var.branch}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com",
        },
      }
    ],
  })
}

resource "aws_iam_policy" "codepipeline_role_policy" {
  name        = "PowerUserAccessPolicy-${var.branch}"
  description = "Policy for CodePipeline and CodeBuild access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "codepipeline:StartPipelineExecution",
          "codepipeline:GetPipelineExecution",
          "codepipeline:GetPipeline",
          "s3:GetObject",
          "s3:PutObject",
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds",
          "codestar-connections:UseConnection",
        ],
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_role_policy.arn
  role       = aws_iam_role.codepipeline_role.name
}
