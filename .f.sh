sef() { 
  if [[ $# -gt 0 ]]; then
    if [[ ! -d $1 ]]; then
      echo "$1 not found"
      return 1
    fi
  fi
  
  du -a $1 | awk '{print $2}' | fzf | xargs -o $EDITOR;
}

