#!/opt/homebrew/bin/bash

cd `dirname $0`

[[ -f config.sh ]] && [[ $CONFIG -ne 1 ]] && . config.sh

cd $PROJ_DIR

for script in $SCRIPT_DIR/enabled/*; do
	[[ -x $script ]] && $script
done
