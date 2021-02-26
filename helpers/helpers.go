package helpers

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

// Lines - reusable varible to hold file content
var Lines []string

func init() {
	Lines = nil
	log.Println("init")
}

// CreateFolder creates a folder
func CreateFolder(folder string, forceCreate int) error {

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

// GetFileLines get all lines from a file
func GetFileLines(filename string) {

	Lines = nil
	f, err := os.OpenFile(filename, os.O_RDONLY, os.ModePerm)
	if err != nil {
		panic(err)
	}
	defer f.Close()
	sc := bufio.NewScanner(f)
	for sc.Scan() {
		Lines = append(Lines, sc.Text())
	}
}

// CheckEnv check env
func CheckEnv(key string, fallback string) string {
	if val, ok := os.LookupEnv(key); ok {
		return val
	}
	return fallback
}

// FindRepoDir find repo dir
func FindRepoDir(homeDir string) string {
	var repoDir = CheckEnv("DOTFILES", fmt.Sprintf("%s/dotfiles", homeDir))
	var dir  = "";
	_, err := os.Stat(repoDir)
	log.Printf("repoDir : %s", repoDir)
	if os.IsNotExist(err) {

		currentDir, err := os.Getwd()
		if err != nil {
			log.Fatal(err)
		}
		dir = currentDir
	}  else {
		dir = repoDir
	}
	return dir
}

// CreateSymLink creates sym link
func CreateSymLink(src string, p string, forceCreate int) error {
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
