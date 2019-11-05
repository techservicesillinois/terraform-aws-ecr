variable "name" {
  description = "Name of repository."
}

variable "disable_lifecycle_policy" {
  description = "If set to 'true', no lifecycle policy is applied."
  default     = false
}

variable "lifecycle_policy_path" {
  description = "Path to JSON document containing lifecycle policy."
  default     = ""
}

variable "readers" {
  description = "List of account ARNs that can pull images."
  type        = list(string)
  default     = []
}

variable "writers" {
  description = "List of account ARNs that can push images."
  type        = list(string)
  default     = []
}
