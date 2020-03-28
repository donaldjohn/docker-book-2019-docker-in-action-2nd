#!/bin/bash

function log {
  local message=$1
  echo "[PROJECT TEST] $message"
}

function execute_maven {
  local d="$1"
  if [[ -f pom.xml ]]; then # maven project
    printf "[PROJECT TEST] %s: " "$d" # no new line
    if [[ -f mvnw ]]; then response=$(./mvnw clean test); else response=$(mvn clean test); fi
    if [[ "$(echo "$response" | grep "BUILD SUCCESS")" != "" ]]; then # success
      echo "Test successfully... ..."
      succ=$((succ + 1))
    else
      echo "Test failed!!!"
      failed=$((failed + 1))
    fi
  fi
}

repo_test_report="$1"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
echo "--------------------------------------------------------------------------------"
log "v0.0.2 - 20200321"
log "$BASEDIR"
log ""

# execute all maven project(s) in this folder
succ=0
failed=0

# if it is singel project
if [[ -d "src" ]]; then
  project_name="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
  project_name=${project_name##*/}  # current folder without full path, for print out only
  execute_maven "$project_name"
else
# for multiple projects
  for d in *; do
    if [[ -d "$d" ]]; then
      cd "$d" || exit
        execute_maven "$d"
      cd "$BASEDIR" || exit
    fi
  done
fi

echo ""
log "Total success: $succ; Total failed: $failed"
echo ""

# append the project test result into repo rest report
if [[ -f "$repo_test_report" ]]; then
  printf "%-50s   SUCCESS: %2d   FAILED: %2d\n" "${BASEDIR##*/}" $succ $failed >> "$repo_test_report"
fi
