variable "workspace" {
  description = "Defines the properties and configuration of the workspace"
  type        = list(map(string))
}

variable "workspace_variables" {
  description = "Defines maps in a list for Variables configuration"
  type = map(object({
    value       = string
    category    = string
    hcl         = bool
    sensitive   = bool
  }))
  default = {}
}

variable "notification_configuration" {
  description = "Defines the configuration of the notification"
  type        = list(map(string))
  default     = []
}

variable "vcs_configuration" {
  type    = list(map(string))
  default = []
}
