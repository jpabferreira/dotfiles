###############################################################################
#                                ZSH FUNCTIONS                                #
###############################################################################
# ---- Filesystem-related -----------------------------------------------------
# flatdir - Move all files in sub-directories to the current directory
flatdir() {
  find . -mindepth 2 -type f -exec mv -f '{}' ./ ';'
}

# cl - Change directory and print contents
cl() {
  builtin cd $@ && ls
}

# ex - Extract a file
ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xjf $1         ;;
      *.tar.gz)  tar xzf $1         ;;
      *.bz2)     bunzip2 $1         ;;
      *.rar)     unrar x $1         ;;
      *.gz)      gunzip $1          ;;
      *.tar)     tar xf $1          ;;
      *.tbz2)    tar xjf $1         ;;
      *.tgz)     tar xzf $1         ;;
      *.zip)     unzip -o $1       	;;
			*.zst)		 tar -I zstd -xf $1	;;
      *.Z)       uncompress $1      ;;
      *.7z)      7z x $1            ;;
      *)         echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# extract - Extract files
extract() {
  for file in "$@"
  do
    if [ -f $file ]; then
      ex $file
    else
      echo "'$file' is not a valid file"
    fi
  done
}

# mkextract - Extract files to their own directories
# TODO: Avoid copying the source archive to its extraction directory
mkextract() {
  for file in "$@"
  do
    if [ -f $file ]; then
      local filename=${file%\.*}
      mkdir -p $filename
      cp $file $filename
      cd $filename
      ex $file
      rm -f $file
      cd -
    else
      echo "'$1' is not a valid file"
    fi
  done
}

# ---- GIT --------------------------------------------------------------------
# giturl - Print the remote URL of the current (cwd) git repo
giturl() {
  cat .git/config | grep -i "url" | awk '{printf "%s\n", $3}'
}

# ---- Markdown ---------------------------------------------------------------
# mdprev - Render and preview a markdown file in qutebrowser
# TODO: Verify arguments
mdprev() {
  if (( $# == 1 ))
	then
    qutebrowser "data:text/html;base64,$(markdown $@ | base64)" 2> /dev/null &
  fi
}

# ---- System -----------------------------------------------------------------
# cheat - Get a cheat sheet from cheat.sh
cheat() {
	curl https://cheat.sh/$1
}

# note - Add a note
note() {
  local msg="$@"
  if (( $# >= 1 ))
  then
    printf "%s\n-------------------\n%s\n\n" $(date "+%d/%m/%Y|%T") "$msg" >> $HOME/Documents/Notes/Notes.txt
  fi
}

# update-font-cache - Normalize font file/directory permissions and update font
# cache
update-font-cache() {
  sudo chmod -R 644 /usr/share/fonts
  sudo chmod -R +X /usr/share/fonts
  sudo chmod -R 644 ~/.local/share/fonts
  sudo chmod -R +X ~/.local/share/fonts
  fc-cache -fv
}
