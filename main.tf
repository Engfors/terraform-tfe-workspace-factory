resource "tfe_workspace" "workspace" {
  count                         = length(var.workspace)
  name                          = lookup(var.workspace[count.index], "name")
  organization                  = lookup(var.workspace[count.index], "organization")
  terraform_version             = lookup(var.workspace[count.index], "terraform_version")
  agent_pool_id                 = lookup(var.workspace[count.index], "agent_pool_id")
  allow_destroy_plan            = lookup(var.workspace[count.index], "allow_destroy_plan")
  assessments_enabled           = lookup(var.workspace[count.index], "assessments_enabled")
  auto_apply                    = lookup(var.workspace[count.index], "auto_apply")
  description                   = lookup(var.workspace[count.index], "description")
  execution_mode                = lookup(var.workspace[count.index], "execution_mode")
  file_triggers_enabled         = lookup(var.workspace[count.index], "file_triggers_enabled")
  global_remote_state           = lookup(var.workspace[count.index], "global_remote_state")
  queue_all_runs                = lookup(var.workspace[count.index], "queue_all_runs")
  remote_state_consumer_ids     = lookup(var.workspace[count.index], "remote_state_consumer_ids")
  speculative_enabled           = lookup(var.workspace[count.index], "speculative_enabled")
  ssh_key_id                    = lookup(var.workspace[count.index], "ssh_key_id")
  structured_run_output_enabled = lookup(var.workspace[count.index], "structured_run_output_enabled")
  tag_names                     = lookup(var.workspace[count.index], "tag_names")
  trigger_patterns              = lookup(var.workspace[count.index], "trigger_patterns")
  # trigger_prefixes              = lookup(var.workspace[count.index], "trigger_prefixes")
  working_directory = lookup(var.workspace[count.index], "working_directory")

  dynamic "vcs_repo" {
    for_each = var.vcs_configuration
    content {
      identifier         = lookup(var.vcs_configuration[count.index], "identifier")
      branch             = lookup(var.vcs_configuration[count.index], "branch")
      ingress_submodules = try(lookup(var.vcs_configuration[count.index], "ingress_submodules"), false)
      oauth_token_id     = lookup(var.vcs_configuration[count.index], "oauth_token_id")
    }
  }
}

resource "tfe_variable" "variable" {
  for_each     = var.workspace_variables
  key          = each.key
  value        = each.value.value
  category     = each.value.category
  hcl          = each.value.hcl
  sensitive    = each.value.sensitive
  workspace_id = tfe_workspace.workspace.0.id
}

resource "tfe_notification_configuration" "notification" {
  count            = length(var.notification_configuration)
  name             = lookup(var.notification_configuration[count.index], "name")
  enabled          = lookup(var.notification_configuration[count.index], "enabled")
  token            = lookup(var.notification_configuration[count.index], "token")
  destination_type = lookup(var.notification_configuration[count.index], "destination_type")
  url              = lookup(var.notification_configuration[count.index], "url")
  workspace_id     = element(tfe_workspace.workspace.*.id, count.index)
  triggers         = [lookup(var.notification_configuration[count.index], "triggers")]
}
