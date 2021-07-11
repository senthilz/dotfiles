package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"

	"github.com/senthilz/dotfiles/helpers"
	"github.com/senthilz/gutilz"
)

var names = map[string]string{
	"tmux.conf":   ".tmux.conf",
	"perltidyrc":  ".perltidyrc",
	"nvim":        ".config/nvim",
	"hammerspoon": ".hammerspoon",
}

func main() {

	homeDir := os.Getenv("HOME")
	configBase := filepath.Join(homeDir, ".config")
	nvimBase := filepath.Join(configBase, "nvim")
	spoonFolder := filepath.Join(homeDir, ".hammerspoon/Spoons")
	var repoDir = helpers.FindRepoDir(homeDir)
	var forceReset int
	flag.IntVar(&forceReset, "f", 0, "Set to true to recreate plugins")
	flag.StringVar(&repoDir, "r", repoDir, "Path to dotfiles")
	flag.Parse()

	fmt.Printf("forceCreate = %+v\n", forceReset)

	log.Printf("repoDir: %s", repoDir)

	for k, v := range names {
		fmt.Println(k, v)
		src := filepath.Join(repoDir, k)
		des := filepath.Join(homeDir, v)
		fmt.Println("::::---------------->", src, des)
		gutilz.CreateSymLink(src, des, 1)
	}

	err := helpers.CreateFolder(spoonFolder, forceReset)
	if err != nil {
		log.Println(err)
	}

	log.Printf("nvimBase = %+v\n", nvimBase)

	c := make(chan string)
	counter := 0

	helpers.GetFileLines(fmt.Sprintf("%s/plugins/spoons.txt", repoDir))
	for _, v := range helpers.Lines {
		counter++
		go helpers.Downloadspoons(v, spoonFolder, c)
	}

	for i := 0; i < counter; i++ {
		log.Printf("%+v\n", <-c)
	}
}
