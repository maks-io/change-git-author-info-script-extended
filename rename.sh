#!/bin/sh

git filter-branch --env-filter '

ARRAY_OF_OLD_EMAILS=("YOUR_OLD_EMAIL_ONE" "YOUR_OLD_EMAIL_TWO" "YOUR_OLD_EMAIL_THREE")
CORRECT_NAME="YOUR_NEW_NAME"
CORRECT_EMAIL="YOUR_NEW_EMAIL"

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

if containsElement "$GIT_COMMITTER_EMAIL" "${ARRAY_OF_OLD_EMAILS[@]}";
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if containsElement "$GIT_AUTHOR_EMAIL" "${ARRAY_OF_OLD_EMAILS[@]}";
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
