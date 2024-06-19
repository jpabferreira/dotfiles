#!/bin/bash
#
# A simple wrapper for pactl to control the output volume and issue desktop
# notifications using notify-send
#

# Setting this variable to
#   - "yes": enables restoring the volume after unmute
#   - "no": sets the volume to 0 after unmute
REMEMBERVOLUME="yes"

printUsageAndDie() {
    echo "$0: invalid argument(s)"
    echo "Usage: $0 [options]"
    echo "Where options are:"
    echo "  -i | --increase: Increase output volume"
    echo "  -d | --decrease: Decrease output volume"
    echo "  -t | --toggleMute: Toggle mute"
    echo ""

    exit 1
}

if (($# != 1)); then
    printUsageAndDie
fi

# Increase/decrease the volume by 1% on each keystroke
STEP=1

# Get the current volume from pactl and format the output to return the percentage
# -> Use awk to filter the 5th element of 1st line without the '%' character
TARGETVOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1 {gsub("%",""); print $5}')
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

case $1 in
-i | --increase) # Increase volume
    if [[ "$MUTED" == "yes" ]]; then
        # Unmute first
        pactl set-sink-mute @DEFAULT_SINK@ "no"
        # Update the variable (prevents setting the "mute" icon further ahead)
        MUTED="no"
    fi

    TARGETVOLUME=$((TARGETVOLUME + STEP))
    # Don't allow values past 100%
    if (($(echo "$TARGETVOLUME > 100" | bc -l))); then
        TARGETVOLUME=100
    fi
    pactl set-sink-volume @DEFAULT_SINK@ $TARGETVOLUME%
    ;;

-d | --decrease) # Decrease volume
    TARGETVOLUME=$((TARGETVOLUME - STEP))
    # Don't allow values past 100%
    if (($(echo "$TARGETVOLUME <= 0" | bc -l))); then
        # Update the variable (in order to set the "mute" icon further ahead)
        MUTED="yes"

        if [[ "$REMEMBERVOLUME" == "no" ]]; then
            TARGETVOLUME='0'
        fi

        # Mute and do nothing else
        pactl set-sink-mute @DEFAULT_SINK@ "yes"

    fi
    # Decrease the volume even if muted
    pactl set-sink-volume @DEFAULT_SINK@ $TARGETVOLUME%
    ;;

-t | --toggleMute) # Toggle mute
    if [[ "$MUTED" == "yes" ]]; then
        # Unmute and do nothing else
        pactl set-sink-mute @DEFAULT_SINK@ "no"
        # Update the variable (prevents setting the "mute" icon further ahead)
        MUTED="no"
    else
        pactl set-sink-mute @DEFAULT_SINK@ "yes"
        # Update the variable (in order to set the "mute" icon further ahead)
        MUTED="yes"

        if [[ "$REMEMBERVOLUME" == "no" ]]; then
            # Set the volume as 0
            TARGETVOLUME='0'
            pactl set-sink-volume @DEFAULT_SINK@ $TARGETVOLUME%
        fi
    fi
    ;;
*)
    printUsageAndDie
    ;;
esac

NAPP="VolumeControl"
NTITLE="Output volume"
NTEXT="$TARGETVOLUME%"
NHINT="int:value:$TARGETVOLUME"

if [[ "$MUTED" == "yes" ]]; then
    # Muted icon (from /usr/share/icons/[Theme]/[Size]/status/)
    ICON="notification-audio-volume-muted"
    NTITLE="Output"
    NTEXT="Muted"
    NHINT=""

    # Send mute notification
    notify-send "$NTITLE" "$NTEXT" -a "$NAPP" -i "$ICON" -h string:x-canonical-private-synchronous:volume
    exit 0
fi

if (($(echo "$TARGETVOLUME > 100 - $STEP" | bc -l))); then
    # High volume icon (from /usr/share/icons/[Theme]/[Size]/status/)
    ICON="notification-audio-volume-high"
elif (($(echo "$TARGETVOLUME > 35" | bc -l))); then
    # Medium volume icon (from /usr/share/icons/[Theme]/[Size]/status/)
    ICON="notification-audio-volume-medium"
elif (($(echo "$TARGETVOLUME >= $STEP" | bc -l))); then
    # Low volume icon (from /usr/share/icons/[Theme]/[Size]/status/)
    ICON="notification-audio-volume-low"
else
    # Volume OFF icon (from /usr/share/icons/[Theme]/[Size]/status/)
    ICON="notification-audio-volume-off"
fi

# Send volume change notification
notify-send "$NTITLE" "$NTEXT" -a "$NAPP" -h "$NHINT" -i "$ICON" -h string:x-canonical-private-synchronous:volume
exit 0
