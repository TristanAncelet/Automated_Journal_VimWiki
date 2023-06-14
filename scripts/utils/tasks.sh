#!/usr/bin/bash
[[ -f ~/Journal/utils/journals.sh ]] && . ~/Journal/utils/journals.sh

function get_tasks () {
	set -x
	local -a journals
	get_journals journals

	local TASK_REGEX='====[[:space:]]+.+[[:space:]]+===='

	declare -n TODO="$1"
	declare -n DONE="$2"

	for journal in "${journals[@]}"; do
		if grep -Eo $TASK_REGEX $journal >/dev/null 2>&1; then

			while read line; do
				if [[ "$line" == *'(DUE: DONE)'* ]]; then
					DONE["$journal"]="$( echo -e "${DONE["$journal"]}\n$line" )"
				else
					TODO["$journal"]="$( echo -e "${TODO["$journal"]}\n$line" )"
				fi
			done <<< "$( grep -Eo $TASK_REGEX $journal | tr '=' ' ')"
		fi
	done
}
