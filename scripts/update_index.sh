#!/opt/homebrew/bin/bash

[[ $CONFIG -ne 1 ]] && [[ -f config.sh ]] && . config.sh

import journals

JOURNAL_INDEX=$PROJ_DIR/index.wiki
declare -a journals
get_journals journals

echo "
%title Journal Index
-----------------------------------------------
$SITE_NAV
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
