#!/usr/bin/bash

#set -x

JOURNAL_DIR=/home/tristan/Journal
JOURNAL_SCRIPT_DIR=$JOURNAL_DIR/scripts
[[ -f $JOURNAL_SCRIPT_DIR/utils/journals.sh ]] && . $JOURNAL_SCRIPT_DIR/utils/journals.sh

JOURNAL_INDEX=$JOURNAL_DIR/index.wiki

declare -a journals
get_journals journals

echo "
%title Journal Index
[[full_index.wiki|Full Index]]

# Journals
$( 
for journal in ${journals[@]}; do
	echo "- [[$journal|$( echo $journal | cut -d'.' -f 1 | tr '-' ' ')]]"
done
)

"  > $JOURNAL_INDEX
