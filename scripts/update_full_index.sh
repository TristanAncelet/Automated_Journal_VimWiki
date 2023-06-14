#!/usr/bin/bash

#set -x

JOURNAL_DIR=~/Journal
JOURNAL_SCRIPT_DIR=$JOURNAL_DIR/scripts
[[ -f $JOURNAL_SCRIPT_DIR/utils/journals.sh ]] && . $JOURNAL_SCRIPT_DIR/utils/journals.sh
JOURNAL_FULL_INDEX=$JOURNAL_DIR/full_index.wiki

declare -a journals
get_journals journals

echo "
%title Full Index

# Journals: Times & Topics
$( 
for file in ${journals[@]}; do
	echo -e '\n\n'
	echo "[[$file|$(echo $file | cut -d '.' -f 1 | tr '-' ' ')]]"

	echo "# Times"
	while read time; do
		echo "  - [[$file#$time|$time]]"
	done <<< "$( grep '== ' $file | grep -Eo '[0-9]+:[0-9]+ [A-Za-z]{2} [A-Za-z]{3}')"

	echo 

	echo "# Topics"
	while read topic; do
		echo "  - [[$file#$topic|$topic]]"
	done <<< "$( grep -Eo '^===[=]* .+ ===[=]*' $file | tr '=' ' ' | sort -u)"
done
)


"  > $JOURNAL_FULL_INDEX
