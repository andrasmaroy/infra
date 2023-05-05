resource "tailscale_acl" "main" {
  acl = jsonencode({
    acls : [
      {
        // Allow all users access to all ports.
        action = "accept",
        users  = ["*"],
        ports  = ["*:*"],
    }],
    "tagowners" : {
      "tag:kubi" : ["autogroup:admin"]
    },
    "autoapprovers" : {
      "routes" : {
        nonsensitive(local.secrets.routes) : ["tag:kubi"],
      },
      "exitNode" : ["tag:kubi"],
    },
  })
}

resource "tailscale_tailnet_key" "kubi" {
  reusable      = true
  ephemeral     = true
  preauthorized = true
  tags = [
    "tag:kubi"
  ]
}
