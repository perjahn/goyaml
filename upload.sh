#!/usr/bin/env bash
set -e

baseurl="https://api.github.com/repos/$GITHUB_REPOSITORY"
baseurluploads="https://uploads.github.com/repos/$GITHUB_REPOSITORY"
accept="Accept: application/vnd.github+json"
auth="Authorization: Bearer $1"
apiversion="X-GitHub-Api-Version: 2022-11-28"
contenttype="Content-Type: application/zip"

json='{"tag_name":"v1.0.'"$GITHUB_RUN_NUMBER"'","name":"v1.0.'"$GITHUB_RUN_NUMBER"'"}'
newrelease=$(curl -s -X POST -H "$accept" -H "$auth" -H "$apiversion" "$baseurl/releases" -d "$json")
RELEASE_ID=$(jq -r '.id' <<< "$newrelease")

curl -s -X POST -H "$accept" -H "$auth" -H "$apiversion" "$baseurluploads/releases/$RELEASE_ID/assets?name=pkg.tar.gz" --data-binary "@pkg.tar.gz" -H "$contenttype" > /dev/null

echo 'Done!'
