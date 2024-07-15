#!/bin/bash
#
# FZF previewer for the Kitty terminal, supporting the following file types:
# - Image
# - Video (takes a still frame)
# - PDF (generates a cover image)
# - Font files (generates an image sample)
# - Archive files (plays audio and shows metadata)
# - Torrent files
# - Text files / other (previewed with bat)
#
# Depends on:
# - kitty w/ nerd font, fzf, bat, lsd, pdftoppm, als, transmission, id3info
#
# Use as:
# $ fzf --preview='/path/to/preview.sh {}'
#

if [[ $# -ne 1 ]]; then
  echo "usage: $0 FILENAME"
  exit 1
fi

# Print a title on top of the FZF preview window
# Arguments:
# - Title (string)
title() {
		echo "$@"
		printf "%.0s─" $(seq $FZF_PREVIEW_COLUMNS)
		echo ""
}

# Show an image in the FZF preview pane using Kitty's icat
# Arguments:
# - File path (string)
show-img() {
	kitty icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place=$((FZF_PREVIEW_COLUMNS))x$((FZF_PREVIEW_LINES - 2))@0x0 "$@" | sed '$d' | sed $'$s/$/\e[m/'
}

# Regexes to match mime types
MIME_IMG="image/"
MIME_VID="video/"
MIME_TOR="/x-bittorrent"
MIME_PDF="/pdf"
MIME_FON="font/|application/vnd.ms-fontobject|application/vnd.ms-opentype|application/vnd.oasis.opendocument.formula-template"
MIME_ARC="/zip|/gzip|/x-xz|/x-bzip|/x-rar|/gzip|/x-7z-compressed"

# Text to generate font preview
TEXT_SAMPLE="ABCDEFGHIJKLM\nNOPQRSTUVWXYZ\nabcdefghijklm\nnopqrstuvwxyz\n1234567890\n!@$\%(){ }[]\n𝅘𝅥𝅮⁋ℑ𝝨⌛^E↋↺𝒴≸\n◔✌😱☎🌍🥷🩻🚳🜹\n𐆖₿⛧🨁🂡⮘🮕🯵‱"

# File path
retfile="$1"
# File name
fname=$(basename "$retfile")
# Directory path
dpath=$(pwd)
# File path
fpath="$dpath/$retfile"

# Temporary file (preview) path
#
# A preview image for /path/to/file.ext is created in /tmp/path/to/file.ext.jpg
# This ensures that each file in our system has a unique correspondance in /tmp
# and enables us to reuse a previously generated preview. Things will go wrong
# if the original file is changed or replaced between previews.
# /tmp content is flushed between Linux sessions.
#
# TODO: Compare timestamps (preview file creation vs. original file
# modification) to update the preview if the original file has changed.
#
tfpath="/tmp$fpath.jpg"
# Temporary directory (preview) path
tdpath=$(dirname "$tfpath")

# Get the mime type
mime=$(xdg-mime query filetype "$fpath")
# Alternative:
# mime=$(file -b --mime-type "$fpath")

# Make the temporary directory, if needed
if [[ ! -d $tdpath ]]; then
	mkdir -p "$tdpath"
fi

if echo "${mime}" | grep -qF "$MIME_IMG"; then
	title "  Image preview: $fname"

	# Preview image directly
	show-img "$fpath" || echo "  Error previewing image."
elif echo "${mime}" | grep -qF "$MIME_VID"; then
	ok=true

	title "  Video preview: $fname"
	if [[ ! -s $tfpath ]]; then
		ffmpegthumbnailer -i "$fpath" -o "$tfpath" -s 0 || ok=false
	fi

	# Show generated image
	$ok && show-img "$tfpath" || echo "  Error generating video preview."
elif echo "${mime}" | grep -qE "$MIME_FON"; then
	ok=true
	title "  Font preview: $fname"
	if [[ ! -s $tfpath ]]; then
		touch "$tfpath"
		magick -size 800x500 xc:"#2B2B2B" -fill "#E6E1DC" -gravity center -pointsize 35 -font "$fpath" -annotate +0+0 "$TEXT_SAMPLE" -flatten "$tfpath" || ok=false;
	fi

	# Show generated image
	$ok && show-img "$tfpath" || echo "  Error generating font preview."
else
	if [[ -d "$fpath" ]]; then
		title "󱞊  Directory preview"
		lsd --icon=always --color=always --tree --depth 1 "$fpath" | less
	elif echo "${mime}" | grep -qF /pdf; then
		ok=true

		title "  PDF preview: $fname"
		if [[ ! -s $tfpath ]]; then
			pdftoppm -f 1 -l 1 -scale-to 1024 -jpeg -jpegopt quality=100 "$fpath" "$tfpath" || ok=false
		fi

		# Show generated image
		$ok && show-img "$tfpath" || echo "  Error generating PDF preview."
	elif echo "${mime}" | grep -qE "$MIME_ARC"; then
		title "  Archive preview: $fname"
		als "$fpath" 2>/dev/null
	elif echo "${mime}" | grep -qE "$MIME_TOR"; then
		title "  Torrent preview: $fname"
		# Show torrent file details
		transmission-show "$fpath"
	elif echo "${mime}" | grep -qF audio/; then
		title "  Audio preview: $fname"
		# Show ID3 data
		id3info "$fpath"
		# Play audio
		ffplay "$fpath" -nodisp -loglevel quiet
	else
		title "  File preview: $fname"

		# Try to read the file with bat
		bat --style=numbers --color=always "$fpath"
	fi
fi
