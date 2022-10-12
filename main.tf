resource "tfe_workspace" "workspace" {
  count                 = length(var.workspace)
  name                  = lookup(var.workspace[count.index], "name")
  organization          = lookup(var.workspace[count.index], "organization")
  terraform_version     = lookup(var.workspace[count.index], "tf_version")
  auto_apply            = try(lookup(var.workspace[count.index], "auto_apply"), false)
  file_triggers_enabled = try(lookup(var.workspace[count.index], "file_triggers_enabled"), false)
  operations            = try(lookup(var.workspace[count.index], "operations"), true)
  ssh_key_id            = try(lookup(var.workspace[count.index], "ssh_key_id"), "")
  trigger_prefixes      = try(lookup(var.workspace[count.index], "trigger_prefixes"), [])
  working_directory     = try(lookup(var.workspace[count.index], "working_directory"), "")
  queue_all_runs        = try(lookup(var.workspace[count.index], "queue_all_runs"), true)

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
