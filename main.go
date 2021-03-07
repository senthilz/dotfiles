package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"github.com/senthilz/dotfiles/helpers"
)

var names = map[string]string{
	"tmux.conf":  ".tmux.conf",
	"perltidyrc": ".perltidyrc",
	"nvim":       ".config/nvim",
	//	"vimrc":       ".vimrc",
	"hammerspoon": ".hammerspoon",
}

func main() {

	homeDir := os.Getenv("HOME")
	configBase := fmt.Sprintf("%s/.config", homeDir)
	nvimBase := fmt.Sprintf("%s/nvim", configBase)
	var repoDir = helpers.FindRepoDir(homeDir)
	var forceReset int
	flag.IntVar(&forceReset, "f", 0, "Set to true to recreate plugins")
	flag.StringVar(&repoDir, "r", repoDir, "Path to dotfiles")
	flag.Parse()

	fmt.Printf("forceCreate = %+v\n", forceReset)

	log.Printf("repoDir: %s", repoDir)
	pluginFolder := fmt.Sprintf("%s/pack/m/start", nvimBase)
	spoonFolder := fmt.Sprintf("%s/.hammerspoon/Spoons", homeDir)

	folders := []string{pluginFolder, spoonFolder}
	for _, v := range folders {
		err := helpers.CreateFolder(v, forceReset)
		if err != nil {
			log.Println(err)
		}
	}

	for k, v := range names {
		fmt.Println(k, v)
		src := fmt.Sprintf("%s/%s", repoDir, k)
		des := fmt.Sprintf("%s/%s", homeDir, v)
		helpers.CreateSymLink(src, des, 1)
	}

	log.Printf("nvimBase = %+v\n", nvimBase)

	helpers.GetFileLines(fmt.Sprintf("%s/plugins/vim.txt", repoDir))
	c := make(chan string)
	counter := 0
	for _, v := range helpers.Lines {
		counter++
		go helpers.GitClonePlugin(v, pluginFolder, c)
	}

	helpers.GetFileLines(fmt.Sprintf("%s/plugins/spoons.txt", repoDir))
	for _, v := range helpers.Lines {
		counter++
		go helpers.Downloadspoons(v, spoonFolder, c)
	}

	for i := 0; i < counter; i++ {
		log.Printf("%+v\n", <-c)
	}
}
