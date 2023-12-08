#!/usr/local/bin/bash

cd `dirname $0`

[[ -f config.sh ]] && . config.sh

./make_new.sh
./update_hook.sh
