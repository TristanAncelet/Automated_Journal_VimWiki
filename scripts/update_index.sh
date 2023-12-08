#!/opt/homebrew/bin/bash

[[ -f $SCRIPT_DIR/utils/journals.sh ]] && . $SCRIPT_DIR/utils/journals.sh
JOURNAL_INDEX=$PROJ_DIR/index.wiki

declare -a journals
get_journals journals

echo "
%title Journal Index
-----------------------------------------------
[[/index.wiki|Index]] [[full_index.wiki|Full Index]] [[tasks.wiki|Tasks Index]] [[how-to.wiki|How-To Index]]
-----------------------------------------------

Journals
--------
$( 
for journal_path in ${journals[@]}; do
	journal_file="${journal_path/*\/}"
	journal_name="$( echo $journal_file | cut -d '.' -f 1 | tr '-' '/' )"
	echo "- [[$journal_path|$journal_name]]"
done
)

"  > $JOURNAL_INDEX
