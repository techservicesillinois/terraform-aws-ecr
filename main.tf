locals {
  lifecycle_policy_path = var.lifecycle_policy_path != "" ? var.lifecycle_policy_path : "${path.module}/lifecycle.json"
}

resource "aws_ecr_repository" "default" {
  name = var.name
}

# Only one of the following aws_ecr_repository_policy resources will be built
#------------------------------------------------
resource "aws_ecr_repository_policy" "readers_writers" {
  count = length(var.readers) > 0 && length(var.writers) > 0 ? 1 : 0

  repository = aws_ecr_repository.default.name
  policy     = data.aws_iam_policy_document.readers_writers.json
}

resource "aws_ecr_repository_policy" "readers" {
  count = length(var.readers) > 0 && length(var.writers) == 0 ? 1 : 0

  repository = aws_ecr_repository.default.name
  policy     = data.aws_iam_policy_document.readers.json
}

resource "aws_ecr_repository_policy" "writers" {
  count = length(var.readers) == 0 && length(var.writers) > 0 ? 1 : 0

  repository = aws_ecr_repository.default.name
  policy     = data.aws_iam_policy_document.writers.json
}

#------------------------------------------------

resource "aws_ecr_lifecycle_policy" "default" {
  count      = var.disable_lifecycle_policy ? 0 : 1
  repository = aws_ecr_repository.default.name
  policy     = file(local.lifecycle_policy_path)
}
