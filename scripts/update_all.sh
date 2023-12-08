#!/opt/homebrew/bin/bash
export PROJ_DIR=~/Notes
export JOURNAL_DIR=$PROJ_DIR/wikis
export FILES_DIR=$PROJ_DIR/files
export SCRIPT_DIR=$PROJ_DIR/scripts

cd $PROJ_DIR

for script in $SCRIPT_DIR/enabled/**; do
	[[ -x $script ]] && $script
done
