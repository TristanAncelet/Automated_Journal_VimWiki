#!/usr/local/bin/bash

[[ $CONFIG -ne 1 ]] && {
	cd `dirname $0`
	[[ -f config.sh ]] && . config.sh
}


cat > $PROJ_DIR/tickets.wiki <<EOF

%title Tickets

----------------------
$SITE_NAV
----------------------

= Tickets =
-----------
`
for file in $TICKET_DIR/*; do
	FILENAME="${file/*\/}"
	FILENAME="${FILENAME/\.*}"
	echo "- [[/ticket/$FILENAME|${FILENAME^^}]]"
done
`

EOF
