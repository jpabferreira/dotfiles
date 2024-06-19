#  _____  _____ __  __   ______                 __  _                 
# /__  / / ___// / / /  / ____/_  ______  _____/ /_(_)___  ____  _____
#   / /  \__ \/ /_/ /  / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
#  / /_____/ / __  /  / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  ) 
# /____/____/_/ /_/  /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/  
#

## key-codes ##
# Filter Xorg keycodes from xev event viewer
key-codes() {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# Extract files
extract() {
  for file in "$@"
  do
    if [ -f $file ]; then
      _ex $file
    else
      echo "'$file' is not a valid file"
    fi
  done
}

# Extract files to their own directories
# TODO: Avoid copying the source archive to its extraction directory
mkextract() {
  for file in "$@"
  do
    if [ -f $file ]; then
      local filename=${file%\.*}
      mkdir -p $filename
      cp $file $filename
      cd $filename
      _ex $file
      rm -f $file
      cd -
    else
      echo "'$1' is not a valid file"
    fi
  done
}

## ex - Archive Extractor ##
# usage: ex <file>
_ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1         ;;
      *.tar.gz)    tar xzf $1         ;;
      *.bz2)       bunzip2 $1         ;;
      *.rar)       unrar x $1         ;;
      *.gz)        gunzip $1          ;;
      *.tar)       tar xf $1          ;;
      *.tbz2)      tar xjf $1         ;;
      *.tgz)       tar xzf $1         ;;
      *.zip)       unzip -o $1         	;;
			*.zst)			 tar -I zstd -xf $1	;;
      *.Z)         uncompress $1      ;;
      *.7z)        7z x $1            ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

## man ##
# Use batman as pager for man. Search with fzf if no parameter is passed
# Requires batman
# _man() {
#   [ "$*" ] && \
#     batman "$@" || \
#     command man -k . | fzf | cut -d " " -f1 | xargs -I {} -r batman {}
# }
# alias man='_man'

## Google Search ##
# Perform a google search in a new chrome window
google() {
  search=""
  echo "Googling: $@"
  for term in $@; do
      search="$search%20$term"
  done
  google-chrome-stable "http://www.google.com/search?q=$search"
}

## flatten ##
# Move all files in sub-directories to the parent (current) directory. TODO: delete sub-directories
flatten() {
  find . -mindepth 2 -type f -exec mv -f '{}' ./ ';'
}

## update-font-cache ##
# Normalize permissions across all font files in /usr/share/fonts and update the font cache
update-font-cache() {
  sudo chmod -R 644 /usr/share/fonts
  sudo chmod -R +X /usr/share/fonts
  sudo chmod -R 644 ~/.local/share/fonts
  sudo chmod -R +X ~/.local/share/fonts
  # sudo chmod -R 644 /var/cache/fontconfig
  # sudo chmod -R +X /var/cache/fontconfig
  fc-cache -fv
}

## fs-charset ##
# Print the list of chars supported by a given font file (format supported by kitty config 'symbol_map')
fc-charset() {
	fc-query --format='%{charset}\n' $@ | sed -E 's/([a-zA-Z0-9]*-?)/U+\1/g' | tr " " "," | tr '[a-z]' '[A-Z]'
}

## fs-char ##
# List all fonts containing the specified character
fc-char() {
	if (( $# == 1 ))
	then
		fc-list :charset=$@ : family spacing outline scalable | sort | grep -e spacing=100 -e spacing=90 | grep -e outline=True | grep -e scalable=True
	fi
}

## Get Cheat sheet at cheat.sh ##
cheat() {
	curl https://cheat.sh/$1
}

search() {
  find -iname "*$1*"
}

giturl() {
  cat .git/config | grep -i "url" | awk '{printf "%s\n", $3}'
}

# Render and preview markdown in qutebrowser
mdprev() {
  if (( $# == 1 ))
	then
    qutebrowser "data:text/html;base64,$(markdown $@ | base64)" 2> /dev/null &
  fi
}

note() {
  local msg="$@"
  if (( $# >= 1 ))
  then
    printf "%s\n-------------------\n%s\n\n" $(date "+%d/%m/%Y|%T") "$msg" >> /home/joao/Documents/Notes/Notes.txt
  fi
}

# Change directory and print contents
cl() {
  # echo $@
  builtin cd $@ && ls
}
