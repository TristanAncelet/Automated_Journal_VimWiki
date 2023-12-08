#!/usr/local/bin/bash


export PROJ_DIR=~/Notes
export JOURNAL_DIR=$PROJ_DIR/wikis
export SCRIPT_DIR=$PROJ_DIR/scripts
export FILES_DIR=$PROJ_DIR/files
export SUBJECTS_DIR=$PROJ_DIR/subjects
export UTILS_DIR=$SCRIPT_DIR/utils

function import () {
	local SCRIPT_NAME="${1:?"import : script name not provided"}"
	local SCRIPT_PATH=$UTILS_DIR/$SCRIPT_NAME

	if [[ ! "$SCRIPT_PATH" =~ ^.*\.sh$ ]]; then
		SCRIPT_PATH+=".sh"
	fi

	if [[ -f $SCRIPT_PATH ]]; then
		. $SCRIPT_PATH
	else
		echo "import : $SCRIPT_PATH does not exist. Exiting program"
		exit 1
	fi

}