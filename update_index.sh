#!/usr/bin/bash

#set -x

JOURNAL_DIR=/home/tristan/Journal
JOURNAL_INDEX=$JOURNAL_DIR/index.wiki

declare -A topics 

for file in $JOURNAL_DIR/*.wiki; do
	if [[ -f $file ]]; then
		while read topic; do
			[[ "$topic" == "" ]] && continue
			base=`basename $file`
			topics+=( ["$topic"]="$base" )	
		# Remember == .* == is reserved for times of entry
	done <<< "$( grep -Eo '= .^ =|=== .* ===' $file | tr '=' ' ' )"
	fi
done

echo "%title Journal Index

"  > $JOURNAL_INDEX

printf -v topic_string '%s\n' "${!topics[@]}"

# Since the hash-table will auto sort things
while read topic; do
	[[ "$topic" == "" ]] && continue
	file="${topics["$topic"]}"
	echo "[[$file#$topic|$topic]]" >> $JOURNAL_INDEX
done <<< "$( sort -i <<< "$topic_string" )"
