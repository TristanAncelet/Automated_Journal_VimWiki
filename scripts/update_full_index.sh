#!/opt/homebrew/bin/bash

[[ $CONFIG -ne 1 ]] && [[ -f config.sh ]] && . config.sh
import journals
JOURNAL_FULL_INDEX=$PROJ_DIR/full_index.wiki

declare -a journals
get_journals journals

echo "
%title Full Index

# Journals: Times & Topics
$( 
for file_path in ${journals[@]}; do
	file="${file_path/*\/}"
	journal_full_path=$PROJ_DIR$file_path
	echo -e '\n\n'
	echo "[[$file_path|$(echo $file | cut -d '.' -f 1 | tr '-' '/')]]"

	echo "# Times"
	while read time; do
		echo "  - [[$file_path#$time|$time]]"
	done <<< "$( grep '== ' $journal_full_path | grep -Eo '[0-9]+:[0-9]+ [A-Za-z]{2} [A-Za-z]{3}')"

	echo 

	echo "# Topics"
	while read topic; do
		echo "  - [[$file_path#$topic|$topic]]"
	done <<< "$( grep -Eo '^===[=]* .+ ===[=]*' $journal_full_path | tr '=' ' ' | sort -u)"
done
)


"  > $JOURNAL_FULL_INDEX
