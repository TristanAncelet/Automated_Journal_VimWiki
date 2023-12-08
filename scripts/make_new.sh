#!/opt/homebrew/bin/bash

[[ $CONFIG -ne 1 ]] && [[ -f config.sh ]] && . config.sh
cd $JOURNAL_DIR
DATE=`date +'%Y-%m-%d'`
FILE="$JOURNAL_DIR/$DATE.wiki"

import journals

# Getting the last journal entry file
declare -a journals
get_journals journals
LAST_JOURNAL_ENTRY="${journals[-1]}"
LAST_JOURNAL_ENTRY="${LAST_JOURNAL_ENTRY/*\/}"

declare -A topics

[[ -f $file ]] && exit

while read line; do
	# Stripping the '=' characters from the topic
	declare -i level=$( tr -cd '=' <<< "$line" | wc -c)
	[[ $level -eq 0 ]] && { echo "A line ($line) that was grabbed returned a 0 count level?"; continue; }

	# Getting the topic "level" by getting the number of = in the topic and dividing it by 2
	#
	# LEVELS:
	#   1: Topic
	#   2: Times
	#   3->5: Subtopic during timeframe
	level=$(( $level / 2 ))
	topic="${line//=/}"
	topics+=( ["$topic"]=$level )
done <<< "$( grep -Eo '=+ .* =+' $LAST_JOURNAL_ENTRY )"

[[ -f "$file" ]] && exit 0

echo "[[$LAST_JOURNAL_ENTRY|Last Journal Entry]]

%title $DATE Journal Entry

---------------------
$SITE_NAV
---------------------

Main Topics from previous journal entry
---------------------------------------
$( for topic in "${!topics[@]}"; do 
	level=${topics["$topic"]}
	[[ $level -eq 1 ]] && echo "- [[$LAST_JOURNAL_ENTRY#$topic|$topic]]"; 
done )

Times
-----
$( for topic in "${!topics[@]}"; do 
	level=${topics["$topic"]}
	[[ $level -eq 2 ]] && echo "- [[$LAST_JOURNAL_ENTRY#$topic|$topic]]"; 
done )

Subtopics
---------
$( for topic in "${!topics[@]}"; do 
	level=${topics["$topic"]}
	[[ $level -gt 2 ]] && echo "- [[$LAST_JOURNAL_ENTRY#$topic|$topic]]"; 
done )


" > $FILE

