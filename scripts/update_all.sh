#!/usr/bin/bash
JOURNAL_DIR=~/Journal
FILES_DIR=$JOURNAL_DIR/files
SCRIPT_DIR=$JOURNAL_DIR/scripts/enabled

#set -x

cd $JOURNAL_DIR

for script in $SCRIPT_DIR/*; do
	[[ -x $script ]] && $script
done
