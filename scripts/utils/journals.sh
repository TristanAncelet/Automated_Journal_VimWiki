#!/opt/homebrew/bin/bash


function get_journals () {
	local JOURNAL_REGEX='[0-9]{4}-[0-9]{2}-[0-9]{2}.wiki'
	declare -n array="${1:?"get_journals : Variable not passed through"}"
	array=( $( ls -1 $JOURNAL_DIR | grep -Eo $JOURNAL_REGEX | sort -n ) )

	local file
	for i in ${!array[@]}; do
		file="${array[$i]}"
		DIR=`basename $JOURNAL_DIR`
		if [[ "$file" != $DIR/* ]]; then
			file="/$DIR/$file"
			array[$i]=$file
		fi
	done
}
