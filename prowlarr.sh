#!/usr/bin/env bash

ntfy_url="https://ntfy.sh/mytopic"
ntfy_username=""
ntfy_password=""
# Added in v1.28.0. Leave empty if you do not want an icon.
ntfy_icon="https://raw.githubusercontent.com/Prowlarr/Prowlarr/develop/Logo/48.png"

if [ -z "$ntfy_password" ]; then
  ntfy_auth=""
else
  ntfy_auth="-u $ntfy_username:$ntfy_password"
fi

ntfy_title="$prowlarr_health_issue_type"
ntfy_message=" "
if [ "$prowlarr_eventtype" == "Test" ]; then
  ntfy_tag=information_source
  ntfy_title="Testing"
elif [ "$prowlarr_eventtype" == "HealthIssue" ]; then
  ntfy_tag=warning
  ntfy_message+=" - "
  ntfy_message+="$prowlarr_health_issue_message"
fi

curl $ntfy_auth \
-u $ntfy_username:$ntfy_password \
-H "tags:"$ntfy_tag \
-H "X-Title: Prowlarr: $prowlarr_eventtype" \
-H "X-Icon: $ntfy_icon" \
-d "$ntfy_title""$ntfy_message" \
--request POST $ntfy_url

exit 0
