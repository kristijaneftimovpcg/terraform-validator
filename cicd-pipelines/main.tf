resource "aws_iam_role" "default_role" {
  name = "default-ci-cd-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = "${module.codebuild_config.codebuild_role.arn}"
        },
      },
    ],
  })
  depends_on = [
    module.codebuild_config.codebuild_role
  ]
}

module "codebuild_config" {
  source                    = "./modules/aws-codebuild"
  codebuild_name            = "terraform-validator-codebuild"
  source_type               = "CODEPIPELINE"
  artifacts_type            = "CODEPIPELINE"
  codebuild_commands_path   = "../deploy.yml"
  policy_additional_actions = []
  eks_cb_kubectl_role_arn   = aws_iam_role.default_role.arn
  tags = var.tags
}

module "codepipeline_config" {
  source                    = "./modules/aws-cicd"
  codepipeline_name         = var.codepipeline_name
  s3_bucket_name            = var.s3_bucket_name
  repository_name           = var.repository_name
  organization_name         = var.organization_name
  branch                    = var.branch
  codebuild_project_name    = module.codebuild_config.codebuild_project_name
  policy_additional_actions = []
  depends_on                = [module.codebuild_config]
}
