# Dotfiles
dotfiles for macOS using Neovim, Hammerspoon and Tmux

## Setup
Clone this repo into your `$HOME` directory. if you prefer any other loction, you should set that path to `DOTFILES`  env variable

```
git clone git@github.com:senthilz/dotfiles.git $HOME/dotfiles
$HOME/dotfiles/setup-dotfiles
```

If you don't have golang installed, just execute this binary `$HOME/dotfiles/setup-dotfiles`
 
`setup-dotfiles` binary is generted using [dotfiles/setup.go](https://github.com/senthilz/dotfiles/blob/master/setup.go)
   
    
If you run `setup-dotfiles` with `-f 1` flag, it will delete and pull the plugins listed in [vim_plugins](https://github.com/senthilz/dotfiles/blob/master/vim_plugins.txt) again
