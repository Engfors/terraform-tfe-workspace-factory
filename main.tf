resource "tfe_workspace" "workspace" {
  count                 = length(var.workspace)
  name                  = lookup(var.workspace[count.index], "name")
  organization          = lookup(var.workspace[count.index], "organization")
  auto_apply            = lookup(var.workspace[count.index], "auto_apply")
  file_triggers_enabled = lookup(var.workspace[count.index], "file_triggers_enabled")
  operations            = lookup(var.workspace[count.index], "operations")
  ssh_key_id            = lookup(var.workspace[count.index], "ssh_key_id")
  trigger_prefixes      = [lookup(var.workspace[count.index], "trigger_prefixes")]
  working_directory     = lookup(var.workspace[count.index], "working_directory")
  terraform_version     = lookup(var.workspace[count.index], "tf_version")
  queue_all_runs        = lookup(var.workspace[count.index], "queue_all_runs")

  dynamic "vcs_repo" {
    for_each = var.vcs_configuration
    content {
      identifier         = lookup(var.vcs_configuration[count.index], "identifier")
      branch             = lookup(var.vcs_configuration[count.index], "branch")
      ingress_submodules = lookup(var.vcs_configuration[count.index], "ingress_submodules")
      oauth_token_id     = lookup(var.vcs_configuration[count.index], "oauth_token_id")
    }
  }
}

resource "tfe_variable" "variable" {
  count        = length(var.workspace_variables)
  key          = lookup(var.workspace_variables[count.index], "key")
  value        = lookup(var.workspace_variables[count.index], "value")
  category     = lookup(var.workspace_variables[count.index], "category")
  hcl          = lookup(var.workspace_variables[count.index], "hcl")
  sensitive    = lookup(var.workspace_variables[count.index], "sensitive")
  workspace_id = element(tfe_workspace.workspace.*.id, count.index)
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
