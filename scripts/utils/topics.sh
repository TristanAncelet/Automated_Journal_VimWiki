#!/opt/homebrew/bin/bash
[[ -f ~/Notes/utils/journals.sh ]] && . ~/Notes/utils/journals.sh

function get_tasks () {
	local -a journals
	get_journals journals
	local TOPIC_REGEX='^=== .+ ==='

	declare -n TOPICS="$1"

	for journal in "${journals[@]}"; do
		if grep -E "$TOPIC_REGEX" $journal >/dev/null 2>&1; then
			TOPICS["$journal"]="$( grep -Eo "$TOPIC_REGEX" $journal | tr '=' ' ' )"
		fi
	done
}
