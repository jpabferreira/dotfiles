#!/bin/bash
#
# A simple script to control MPD playback and issue desktop notifications using
# mpc and notify-send
#

NOTIFY=false

printUsageAndDie() {
    echo "$0: invalid argument(s)"
    echo "Usage: $0 [options]"
    echo "Where options are:"
    echo "  -t: Play/Pause"
    echo "  -n: Next track"
    echo "  -b: Previous track"
    echo ""

    exit 1
}

if (($# != 1)); then
	printUsageAndDie
fi

OUTPUT=""
case $1 in
-t) # Toggle play/pause
	OUTPUT=$(mpc toggle)
	;;

-n) # Next track
	OUTPUT=$(mpc next)
	;;

-p) # Previous track
	OUTPUT=$(mpc prev)
	;;
*)
	printUsageAndDie
	;;
esac

SONG=$(awk 'NR==1 {print;exit}' <<<"$OUTPUT")
STATUS=$(awk 'NR==2 {print $1;exit}' <<<"$OUTPUT")
if [[ "$STATUS" == "[playing]" ]]; then
	ICON="media-playback-start"
	NTEXT="Playing: $SONG"
elif [[ "$STATUS" == "[paused]" ]]; then
	ICON="media-playback-pause"
	NTEXT="Paused"
fi

if [[ $NOTIFY == 'true' ]]; then
	NAPP="MPDControl"
	NTITLE="Music Player Daemon (MPD)"

	# Send volume change notification
	notify-send "$NTITLE" "$NTEXT" -a "$NAPP" -i "$ICON" -h string:x-canonical-private-synchronous:mpd
fi
exit 0
