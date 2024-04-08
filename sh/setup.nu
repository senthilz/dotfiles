mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
echo "\n# below lines are added by setup.nu"
let sf_cache = "use ~/.cache/starship/init.nu" 

echo sf_cache, "\n" | save $nu.env-path --append
brew install hammerspoon --cask
brew install bat git-delta nvim fzf nvim tmux nushell go rustup
