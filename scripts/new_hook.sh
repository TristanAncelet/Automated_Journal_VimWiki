#!/usr/local/bin/bash

export PROJECT_DIR=~/Notes
export SCRIPT_DIR=$PROJECT_DIR/scripts
export JOURNAL_DIR=$PROJECT_DIR/wikis

cd $SCRIPT_DIR

./make_new.sh
./update_all.sh
