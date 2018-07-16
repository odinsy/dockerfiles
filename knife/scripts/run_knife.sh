#!/usr/bin/env bash

script="$0"
command="$1"
knife_config_path="/opt/knife/knife.rb"
knife_options="-c $knife_config_path"

usage() {
  echo "Usage: $script command"
  echo "Where command is:"
  echo "init        :  for generating Chef client.pem for knife"
  echo "upload_env  :  for uploading environment(s)"
  echo "upload_role :  for uploading role(s)"
  echo "upload_bag  :  for uploading data bag(s)"
  echo "show_info   :  for get info about compared commits"
  exit 0
}

show_compared_commits() {
  echo -e "Diff between commits $DRONE_PREV_COMMIT_SHA and $DRONE_COMMIT_SHA \n"
}

exit_with_empty_line() {
  echo -en "\n" ; exit 0
}

generate_certificate() {
  cat > /opt/knife/client.pem << EOF
  $CHEF_CLIENT_KEY
EOF
}

debug() {
  echo $CHEF_CLIENT_KEY
  echo $CHEF_USER
  echo $CHEF_SERVER_URL
}

upload_env() {
  changed_environments="$(git diff-tree --no-commit-id --name-only -r $DRONE_PREV_COMMIT_SHA $DRONE_COMMIT_SHA environments)"

  if [[ -n $changed_environments ]]; then
    echo "Uploading ENV(s).."
    knife environment from file $changed_environments $knife_options
  else
    echo "Nothing to do.."
  fi
  exit_with_empty_line
}

upload_role() {
  changed_roles="$(git diff-tree --no-commit-id --name-only -r $DRONE_PREV_COMMIT_SHA $DRONE_COMMIT_SHA roles)"

  if [[ -n $changed_roles ]]; then
    echo "Uploading role(s).."
    knife role from file $changed_roles $knife_options
  else
    echo "Nothing to do.."
  fi
  exit_with_empty_line
}

upload_bag() {
  changed_bags="$(git diff-tree --no-commit-id --name-only -r $DRONE_PREV_COMMIT_SHA $DRONE_COMMIT_SHA data_bags)"

  if [[ -n $changed_bags ]]; then
    for bag in $changed_bags; do
      echo "Uploading bag(s).."
      service="$(echo $bag | cut -d '/' -f 2)"
      knife data bag from file $service $bag $knife_options
    done
  else
    echo "Nothing to do.."
  fi
  exit_with_empty_line
}

case "$command" in
  init)
    generate_certificate
    ;;
  debug)
    debug
    ;;
  show_info)
    show_compared_commits
    ;;
  upload_env)
    upload_env
    ;;
  upload_role)
    upload_role
    ;;
  upload_bag)
    upload_bag
    ;;
  *)
    usage
    ;;
esac
