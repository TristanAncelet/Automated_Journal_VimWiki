#!/usr/bin/bash

JOURNAL_DIR=/home/tristan/Journal
UPDATE_INDEX=$JOURNAL_DIR/update_index.sh
DATE=`date +'%Y-%m-%d'`
FILE="$DATE.wiki"

# Getting the last journal entry file
LAST_JOURNAL_ENTRY=`ls $JOURNAL_DIR/*.wiki -1 | sort -n | tail -n 1`
# Getting just the filename
LAST_JOURNAL_ENTRY=`basename $LAST_JOURNAL_ENTRY`

# Updating my index notes
[[ -f $UPDATE_INDEX ]] && $UPDATE_INDEX

declare -A topics

while read line; do
	# Stripping the '=' characters from the topic
	declare -i level=$( tr -cd '=' <<< "$line" | wc -c)
	[[ $level -eq 0 ]] && { echo "A line ($line) that was grabbed returned a 0 count level?"; exit 1; }

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

# Main Topics from previous journal entry
$( for topic in "${!topics[@]}"; do 
	level=${topics["$topic"]}
	[[ $level -eq 1 ]] && echo "[[$LAST_JOURNAL_ENTRY#$topic|$topic]]"; 
done )

# Times

$( for topic in "${!topics[@]}"; do 
	level=${topics["$topic"]}
	[[ $level -eq 2 ]] && echo "[[$LAST_JOURNAL_ENTRY#$topic|$topic]]"; 
done )

# Subtopics

$( for topic in "${!topics[@]}"; do 
	level=${topics["$topic"]}
	[[ $level -gt 2 ]] && echo "[[$LAST_JOURNAL_ENTRY#$topic|$topic]]"; 
done )


" > $FILE
