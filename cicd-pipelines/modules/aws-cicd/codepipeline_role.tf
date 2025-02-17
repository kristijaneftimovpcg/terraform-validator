# CodePipeline Role
resource "aws_iam_role" "codepipeline_role" {
  name = "terraform-validator-codepipeline-${var.branch}-role"
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
        Action = concat(
          [
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
          var.policy_additional_actions
        ),
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_role_policy.arn
  role       = aws_iam_role.codepipeline_role.name
}