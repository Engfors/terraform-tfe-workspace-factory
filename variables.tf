variable "workspace" {
  description = "Defines the properties and configuration of the workspace"
  type = list(object({
    name                          = string
    organization                  = string
    terraform_version             = string
    agent_pool_id                 = optional(string, "")
    allow_destroy_plan            = optional(bool, true)
    assessments_enabled           = optional(bool, false)
    auto_apply                    = optional(bool, false)
    description                   = optional(string, "")
    execution_mode                = optional(string, "remote")
    file_triggers_enabled         = optional(bool, false)
    global_remote_state           = optional(bool, false)
    queue_all_runs                = optional(bool, true)
    remote_state_consumer_ids     = optional(set(string), [])
    speculative_enabled           = optional(bool, true)
    ssh_key_id                    = optional(string, "")
    structured_run_output_enabled = optional(bool, true)
    tag_names                     = optional(set(string), [])
    trigger_patterns              = optional(set(string), [])
    # trigger_prefixes              = optional(set(string), [])
    working_directory = optional(string, "")
  }))
}

variable "workspace_variables" {
  description = "Defines maps in a list for Variables configuration"
  type = map(object({
    value     = string
    category  = string
    hcl       = bool
    sensitive = bool
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
