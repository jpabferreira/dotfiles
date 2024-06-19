#!/bin/bash

if [[ $# -ne 1 ]]; then
  >&2 echo "usage: $0 FILENAME"
  exit 1
fi

fname=${1/#\~\//$HOME/}
mime=$(xdg-mime query filetype "$fname")
# mime=$(file -b --mime-type "$fname")

if echo ${mime} | grep -qF image/; then
	echo "  Image preview:" $(basename "$fname")
	printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
	echo ""
	kitty icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place=$((FZF_PREVIEW_COLUMNS))x$((FZF_PREVIEW_LINES - 2))@0x0 "$fname" | sed '$d' | sed $'$s/$/\e[m/'
elif echo ${mime} | grep -qF video/; then
	TMP=$(mktemp)
	echo "  Video preview:" $(basename "$fname")
	printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
	echo ""
	ffmpegthumbnailer -i "$fname" -o $TMP -s 0 && kitty icat --clear --transfer-mode=memory ---unicode-placeholder -stdin=no --place=$((FZF_PREVIEW_COLUMNS))x$((FZF_PREVIEW_LINES - 2))@0x0 $TMP | sed '$d' | sed $'$s/$/\e[m/'
	trap "rm -f $TMP" EXIT
elif echo ${mime} | grep -qE "font/|application/vnd.ms-fontobject|application/vnd.ms-opentype|application/vnd.oasis.opendocument.formula-template"; then
	echo "  Font preview:" $(basename "$fname")
	printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
	echo ""
	TMP=$(mktemp /tmp/XXXXXXXX.jpg)
	convert -size 800x500 xc:"#2B2B2B" -fill "#E6E1DC" -gravity center -pointsize 35 -font "$fname" -annotate +0+0 "ABCDEFGHIJKLM\nNOPQRSTUVWXYZ\nabcdefghijklm\nnopqrstuvwxyz\n1234567890\n!@$\%(){ }[]\n𝅘𝅥𝅮⁋ℑ𝝨⌛^E↋↺𝒴≸\n◔✌😱☎🌍🥷🩻🚳🜹\n𐆖₿⛧🨁🂡⮘🮕🯵‱" -flatten $TMP
	kitty icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place=$((FZF_PREVIEW_COLUMNS))x$((FZF_PREVIEW_LINES - 2))@0x0 "$TMP" | sed '$d' | sed $'$s/$/\e[m/'
	trap "rm -f $TMP" EXIT
else
	if [[ -d "$fname" ]]; then
		echo "󱞊  Directory preview"
		printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
		echo ""
		lsd --icon=always --color=always --tree --depth 1 "$fname" | less
	elif echo ${mime} | grep -qF /pdf; then
		echo "  PDF preview:" $(basename "$fname")
		printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
		echo ""
		pdftoppm -f 1 -l 1 -scale-to 1024 -jpeg -jpegopt quality=100 "$fname" /tmp/pdfprev
		kitty icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place=$((FZF_PREVIEW_COLUMNS))x$((FZF_PREVIEW_LINES - 2))@0x0 "/tmp/pdfprev-01.jpg" | sed '$d' | sed $'$s/$/\e[m/'
		trap "rm -f /tmp/pdfprev-01.jpg" EXIT
	elif echo ${mime} | grep -qE "/zip|/gzip|/x-xz|/x-bzip|/x-rar|/gzip|/x-7z-compressed"; then
		echo "  Archive preview:" $(basename "$fname")
		printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
		echo ""
		als "$fname" 2>/dev/null
	elif echo ${mime} | grep -qE "/x-bittorrent"; then
		echo "  Torrent preview:" $(basename "$fname")
		printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
		echo ""
		transmission-show "$fname"
	# elif echo ${mime} | grep -qF audio/mpeg; then
	# 	echo "  ID3 Info:" $(basename "$fname")
	# 	printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
	# 	id3info "$fname"
	elif echo ${mime} | grep -qF audio/; then
		echo "  Audio preview:" $(basename "$fname")
		printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
		id3info "$fname"
		ffplay "$fname" -nodisp -loglevel quiet
	else
		echo "  File preview:" $(basename "$fname")
		printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
		echo ""
		bat --style=numbers --color=always "$fname"
	fi
fi
