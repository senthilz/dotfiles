package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"os"
	"path"

	"github.com/go-git/go-git"
)

var lines []string

func getFileLines(filename string) {

	lines = nil
	f, err := os.OpenFile(filename, os.O_RDONLY, os.ModePerm)
	if err != nil {
		panic(err)
	}
	defer f.Close()
	sc := bufio.NewScanner(f)
	for sc.Scan() {
		lines = append(lines, sc.Text())
	}
}

// createFolder creates a folder
func createFolder(folder string, forceCreate int) error {

	folderInfo, err := os.Stat(folder)
	if os.IsNotExist(err) {
		log.Printf("%s\n", err)
	} else {
		log.Printf("%s already exists\n", folderInfo.Name())
		if forceCreate == 1 {
			log.Println("Deleting folder")
			os.RemoveAll(folder)
		} else {
			return nil
		}
	}

	log.Printf("Creating = %+v\n", folder)
	errDir := os.MkdirAll(folder, 0755)

	if errDir != nil {
		log.Println(errDir)
	} else {
		log.Printf("created = %+v\n", folder)
	}
	return errDir
}

// createSymLink creates sym link
func createSymLink(src string, p string, forceCreate int) error {
	if _, err := os.Lstat(p); err == nil {
		log.Printf("Symlink already exists. = %+v\n", p)

		if forceCreate == 1 {
			log.Printf("Removing symlink...")
			os.Remove(p)
		} else {
			s, _ := os.Readlink(p)

			log.Printf("Symlink %s points to %s", p, s)
			if s != src {
				log.Printf("WARN: Symlink destination is NOT pointing to %s", p)
			}
			return nil
		}
	}

	err := os.Symlink(src, p)
	if err != nil {
		fmt.Println(err)
		return err
	}
	fmt.Printf("Symlink created %s --> %s", p, src)
	return nil
}

var names = map[string]string{
	"tmux.conf": ".tmux.conf",
	"nvim":      ".config/nvim",
	//	"vimrc":       ".vimrc",
	"hammerspoon": ".hammerspoon",
}

// CheckEnv check env
func CheckEnv(key string, fallback string) string {
	if val, ok := os.LookupEnv(key); ok {
		return val
	}
	return fallback
}

func main() {

	homeDir := os.Getenv("HOME")
	configBase := fmt.Sprintf("%s/.config", homeDir)
	nvimBase := fmt.Sprintf("%s/nvim", configBase)
	var repoDir = CheckEnv("DOTFILES", fmt.Sprintf("%s/dotfiles", homeDir))
	var forceReset int
	flag.IntVar(&forceReset, "f", 0, "Set to true to recreate plugins")
	flag.StringVar(&repoDir, "r", repoDir, "Path to dotfiles")
	flag.Parse()

	fmt.Printf("forceCreate = %+v\n", forceReset)

	log.Printf("repoDir: %s", repoDir)
	pluginFolder := fmt.Sprintf("%s/pack/m/start", nvimBase)

	err := createFolder(configBase, forceReset)
	if err != nil {
		log.Println(err)
	}

	for k, v := range names {
		fmt.Println(k, v)
		src := fmt.Sprintf("%s/%s", repoDir, k)
		des := fmt.Sprintf("%s/%s", homeDir, v)
		createSymLink(src, des, 1)
	}

	log.Printf("nvimBase = %+v\n", nvimBase)

	err = createFolder(pluginFolder, forceReset)
	if err != nil {
		log.Println(err)
	}

	getFileLines(fmt.Sprintf("%s/plugins/vim.txt", repoDir))
	c := make(chan string)
	for _, v := range lines {
		go GitClonePlugin(v, pluginFolder, c)
	}

	for i := 0; i < len(lines); i++ {
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
