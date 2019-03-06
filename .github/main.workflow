workflow "Replicated Unstable Release" {
  resolves = "replicated_release"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "replicated_release" {
  uses = "replicatedhq/replicated-action/release@v0.1.1"
  needs = "filter-to-pr-open-synced"
  secrets = [
    "GITHUB_TOKEN",
    "REPLICATED_API_TOKEN"
  ],
  env = {
    REPLICATED_APP = "marcreference"
  }
}
