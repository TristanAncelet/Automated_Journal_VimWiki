#!/usr/bin/bash


function get_journals () {
	local JOURNAL_REGEX='[0-9]{4}-[0-9]{2}-[0-9]{2}.wiki'
	[[ "$1" ]] && declare -n hashmap="$1"
	hashmap=( $( ls $JOURNAL_DIR -1 | grep -Eo $JOURNAL_REGEX | sort -n ) )
}
