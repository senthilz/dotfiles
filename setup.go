package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path"

	"github.com/go-git/go-git/v5"
	"github.com/senthilz/dotfiles/helpers"
)

var names = map[string]string{
	"tmux.conf": ".tmux.conf",
	"nvim":      ".config/nvim",
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

	err := helpers.CreateFolder(configBase, forceReset)
	if err != nil {
		log.Println(err)
	}

	for k, v := range names {
		fmt.Println(k, v)
		src := fmt.Sprintf("%s/%s", repoDir, k)
		des := fmt.Sprintf("%s/%s", homeDir, v)
		helpers.CreateSymLink(src, des, 1)
	}

	log.Printf("nvimBase = %+v\n", nvimBase)

	err = helpers.CreateFolder(pluginFolder, forceReset)
	if err != nil {
		log.Println(err)
	}

	helpers.GetFileLines(fmt.Sprintf("%s/plugins/vim.txt", repoDir))
	c := make(chan string)
	for _, v := range helpers.Lines {
		go GitClonePlugin(v, pluginFolder, c)
	}

	for i := 0; i < len(helpers.Lines); i++ {
		log.Printf("%+v\n", <-c)
	}
}

// GitClonePlugin gi
func GitClonePlugin(repo string, pluginDir string, ch chan string) {

	fmt.Printf("Processing %s", pluginDir)
	b := path.Base(repo)
	f := fmt.Sprintf("%s/%s", pluginDir, b)
	// Clone the given repository into the given dir

	gitURL := fmt.Sprintf("https://github.com/%s", repo)
	fmt.Printf("git clone %s %s\n", gitURL, f)

	_, err := git.PlainClone(f, false, &git.CloneOptions{
		URL:      gitURL,
		Progress: os.Stdout,
	})

	if err != nil {
		ch <- fmt.Sprintf("%s failed with %s", gitURL, err)
		return
	}
	ch <- fmt.Sprintf("== %+v Done.\n", repo)
}
