#!/opt/homebrew/bin/bash
: "
get_task_number
This function will query sqlite db to either get the number of a task OR create the task and return the number

returns:
  -1 - Experienced error
  0  - Task was found
  1  - Task was created
"
function get_task_number() {
	local DB_PATH="${FILES_DIR:?"FILES_DIR was not set"}/task.db"
	local TASK_TITLE="${1:?"Task title was not provided"}"

	local TASK_NUMBER="$( 
		sqlite3 $DB_PATH <<< "
		SELECT 
		"
	)"
}
