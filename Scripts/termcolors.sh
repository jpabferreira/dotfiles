#!/bin/bash

names=(\
	"[Normal] Black"	\
	"[Normal] Red"      \
	"[Normal] Green"    \
	"[Normal] Yellow"	\
	"[Normal] Blue"		\
	"[Normal] Magenta"	\
	"[Normal] Cyan"		\
	"[Normal] White"	\
	"[Bright] Black"	\
	"[Bright] Red"		\
	"[Bright] Green"	\
	"[Bright] Yellow"	\
	"[Bright] Blue"		\
	"[Bright] Magenta"	\
	"[Bright] Cyan"		\
	"[Bright] White"	)

regex="rgb:(..)..\/(..)..\/(..).."

# Get foreground and background by way of "xtermcontrol --get-<bg/fg>"
if [[  $(xtermcontrol --get-bg) =~ $regex ]]; then
	bground+=("#${BASH_REMATCH[1]}${BASH_REMATCH[2]}${BASH_REMATCH[3]}")
fi
if [[  $(xtermcontrol --get-fg) =~ $regex ]]; then
	fground+=("#${BASH_REMATCH[1]}${BASH_REMATCH[2]}${BASH_REMATCH[3]}")
fi

# Get theme colors by way of "xtermcontrol --get-color<n>"
for i in {0..255}
do
	if [[  $(xtermcontrol --get-color$i) =~ $regex ]]; then
		hexcodes+=("#${BASH_REMATCH[1]}${BASH_REMATCH[2]}${BASH_REMATCH[3]}")
	fi
done

printf "\n                     ==========================================\n"
printf "                     ╔╦╗╔═╗╦═╗╔╦╗╦╔╗╔╔═╗╦    ╔═╗╔═╗╦  ╔═╗╦═╗╔═╗\n"
printf "                      ║ ║╣ ╠╦╝║║║║║║║╠═╣║    ║  ║ ║║  ║ ║╠╦╝╚═╗\n"
printf "                      ╩ ╚═╝╩╚═╩ ╩╩╝╚╝╩ ╩╩═╝  ╚═╝╚═╝╩═╝╚═╝╩╚═╚═╝\n"
printf "                     ==========================================\n"

printf "\n\x1b[1m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ THEME COLORS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\x1b[0m\n"

# Print foreground and background
printf "                      ▁▁\n"
printf "          \x1b[39mBackground: ▏▕ [${bground^^}] \x1b[0m\n"
printf "          \x1b[39mForeground: \u2588\u2588 [${fground^^}] \x1b[0m\n"

# Print theme (Xresources) colors
for i in {0..15}
do
	if [[ $bground == ${hexcodes[$i]} ]]; then
		printf "                      ▁▁\n"
		printf "%-2s %-18s ▏▕ [%s] \x1b[0m\n" "${i}" "${names[$i]}" "${hexcodes[$i]^^}"
	else
		printf "\x1b[38;5;${i}m%-2s %-18s \x1b[48;5;${i}m  \x1b[0m \x1b[38;5;${i}m[%s]\x1b[0m \n" "${i}" "${names[$i]}" "${hexcodes[$i]}"
	fi
done

printf "\n\n\x1b[1m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ COLORS 16 TO 231 ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\x1b[0m\n\n"

# Print the remaining colors
cnt=16
for u in {0..2}
do
	for i in {0..5}
	do
		for j in {0..5}
		do
			printf "\x1b[38;5;0m\x1b[48;5;${cnt}m  %-3s %s  \x1b[0m" "$cnt" "${hexcodes[$cnt]^^}"
			cnt=$((cnt+1))
		done

		printf "  "
		cnt=$((cnt+30))
		for j in {0..5}
		do
			printf "\x1b[38;5;0m\x1b[48;5;${cnt}m  %-3s %s  \x1b[0m" "$cnt" "${hexcodes[$cnt]^^}"
			cnt=$((cnt+1))
		done
		cnt=$((cnt-36))
		printf "\n"
	done
	cnt=$((cnt+36))
	printf "\n"
done

printf "\n\x1b[1m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GREY COLORS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\x1b[0m\n\n"

# Print grey tones
cnt=232
for i in {0..1}
do
	for j in {0..5}
	do
		printf "\x1b[48;5;${cnt}m  %-3s %s  \x1b[0m" "$cnt" "${hexcodes[$cnt]^^}"
		cnt=$((cnt+1))
	done
	printf "  "
done

printf "\n"
for i in {0..1}
do
	for j in {0..5}
	do
		printf "\x1b[38;5;0m\x1b[48;5;${cnt}m  %-3s %s  \x1b[0m" "$cnt" "${hexcodes[$cnt]^^}"
		cnt=$((cnt+1))
	done
	printf "  "
done

printf "\n\n\x1b[1m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\x1b[0m\n"

exit 0
