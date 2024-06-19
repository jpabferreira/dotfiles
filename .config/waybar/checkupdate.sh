#!/usr/bin/env bash

# Deals with concurrency when launching multiple bars (several monitors)
while $(pgrep -u joao checkupdates >/dev/null); do
	sleep 1
done

COMMAND=$(checkupdates)
RETVAL=$?

TITLE=" <sup>󰔟</sup>"
TOOLTIP="Checking for updates..."

if [ $RETVAL -eq 0 ]; then
	UPDATES=$(echo "$COMMAND" | wc -l)

	if (($UPDATES == 0)); then
		TITLE=" <sup><span color='#a5c261'>󰄳 </span></sup>"
		TOOLTIP="System up to date"
	else
		TITLE=" <span color='#da4939'><sup>${UPDATES}</sup></span>"

		if (($UPDATES == 1)); then
			TOOLTIP="${UPDATES} update available"
		else
			TOOLTIP="${UPDATES} updates available"
		fi
	fi
elif [ $RETVAL -eq 2 ]; then
  TITLE=" <sup><span color='#a5c261'>󰄳 </span></sup>"
	TOOLTIP="System up to date"
fi

# printf '{"text": "%s", "tooltip": "%s"}' $TEXT $TOOLTIP
echo '{"text": "'$TITLE'", "tooltip": "'$TOOLTIP'"}'
exit 0
