# Code Build Role
resource "aws_iam_role" "codebuild_role" {
  name = "terraform-validator-codebuild-role"
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
  name        = "terraform-validator-codebuild-policy"
  description = "Policy for CodeBuild access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = concat(
        [
          "*"
        ],
        var.policy_additional_actions
      ),
      Resource = "*",
      },
      {
        Sid      = "STSASSUME",
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "${var.eks_cb_kubectl_role_arn}"
      }
    ],
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role       = aws_iam_role.codebuild_role.name
}
