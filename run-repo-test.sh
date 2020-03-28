#!/bin/bash

function log() {
  local message=$1
  echo "[REPO TEST] $message"
}

function execute_project_test() {
  local r="$1"
  test="$(pwd)/run-project-test.sh"
  if [[ -f "${test}" ]]; then
    /bin/bash "${test}" "$1"
  fi
}

clear
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
echo ""
echo "-------------------------------------------------------------------------------------------"
echo "  ____                ____                      _ _                     _____         _    "
echo " |  _ \ _   _ _ __   |  _ \ ___ _ __   ___  ___(_) |_ ___  _ __ _   _  |_   _|__  ___| |_  "
echo " | |_) | | | | '_ \  | |_) / _ \ '_ \ / _ \/ __| | __/ _ \| '__| | | |   | |/ _ \/ __| __| "
echo " |  _ <| |_| | | | | |  _ <  __/ |_) | (_) \__ \ | || (_) | |  | |_| |   | |  __/\__ \ |_  "
echo " |_| \_\\__,_|_| |_| |_| \_\___| .__/ \___/|___/_|\__\___/|_|   \__, |   |_|\___||___/\__| "
echo "                               |_|                              |___/                      "
echo "-------------------------------------------------------------------------------------------"
# http://patorjk.com/software/taag/#p=display&f=Standard&t=Run%20Repository%20Test
log "v0.0.1 - 20200321"
log "$BASEDIR"
log ""

# test report
test_report="/tmp/repo-test-report-${BASEDIR##*/}-$(date "+%s")"
# create test report json
touch "$test_report"

# execute all maven project(s) in this folder
# if it is singel project
if [[ -f "run-project-test.sh" && ! -f ".not-project-test" ]]; then
  execute_project_test "$test_report"
else
  # for multiple projects
  for d in *; do
    if [[ -d "$d" ]]; then
      cd "$d" || exit
      execute_project_test "$test_report"
      cd "$BASEDIR" || exit
    fi
  done
fi

# test report
echo "-------------------------------------------------------------------------------------------"
log "TEST REPORT"
log ""
while IFS= read -r line; do
  log "$line"
done <"$test_report"
echo "-------------------------------------------------------------------------------------------"
