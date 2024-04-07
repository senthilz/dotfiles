#!/bin/bash

sef() { 
  if [[ $# -gt 0 ]]; then
    if [[ ! -d $1 ]]; then
      echo "$1 not found"
      return 1
    fi
  fi
  du -a "$1" | awk '{print $2}' | fzf | xargs -o "$EDITOR"
}

# manage screen shots folder on mac
screenshot_folder() {
  case $1 in
    create)
      df=$(date '+%F-%a')
      local sd="$HOME/Pictures/screenshots/$df"
      mkdir -p "$sd" 
      defaults write com.apple.screencapture location "$sd"
      ;;
    jpg)
      defaults write com.apple.screencapture type jpg
      ;;
    *)
      defaults read com.apple.screencapture 
  esac
}
