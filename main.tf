locals {
  # Use lifecycle policy path specified by user; otherwise use default in-module lifecycle.json file.
  lifecycle_policy_path = var.lifecycle_policy_path != null ? var.lifecycle_policy_path : format("%s/lifecycle.json", path.module)

  # Build list of actions for IAM policy depending on definition of
  # readers and writers.
  actions = sort(distinct(concat(length(var.readers) > 0 ? local.actions_read : [], length(var.writers) > 0 ? local.actions_write : [])))

  # Build list of identifiers depending on definition of readers and writers.
  identifiers = sort(distinct(concat(var.readers, var.writers)))

  # Build list of repo names from aws_ecr_repository resources.
  repo_names = sort([for r in aws_ecr_repository.default : r.name])
}


resource "aws_ecr_repository" "default" {
  for_each = toset(var.repos)
  name     = each.key
  tags     = var.tags
}

resource "aws_ecr_lifecycle_policy" "default" {
  # If lifecycle policy isn't disabled, apply to each repo.
  for_each = toset(var.disable_lifecycle_policy ? [] : local.repo_names)

  repository = each.key
  policy     = file(local.lifecycle_policy_path)
}

resource "aws_ecr_repository_policy" "default" {
  # If identifier list isn't empty (i.e., if readers or writers are
  # defined), apply appropriate IAM policy to each repo.
  for_each = toset(length(local.identifiers) > 0 ? local.repo_names : [])

  repository = each.key
  policy     = data.aws_iam_policy_document.default.json
}
