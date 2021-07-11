package helpers

import (
	"archive/zip"
	"bufio"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"path"
	"path/filepath"
	"regexp"
	"strings"

	"github.com/go-git/go-git/v5"
)

// Lines - reusable varible to hold file content
var Lines []string
var re = regexp.MustCompile(`.*/(\S+.spoon).zip$`)

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
	var dir = ""
	_, err := os.Stat(repoDir)
	log.Printf("repoDir : %s", repoDir)
	if os.IsNotExist(err) {

		currentDir, err := os.Getwd()
		if err != nil {
			log.Fatal(err)
		}
		dir = currentDir
	} else {
		dir = repoDir
	}
	return dir
}

// Unzip un compress zip file
func Unzip(src string, dest string) ([]string, error) {

	var filenames []string

	r, err := zip.OpenReader(src)
	if err != nil {
		return filenames, err
	}
	defer r.Close()

	for _, f := range r.File {

		// Store filename/path for returning and using later on
		fpath := filepath.Join(dest, f.Name)

		// Check for ZipSlip. More Info: http://bit.ly/2MsjAWE
		if !strings.HasPrefix(fpath, filepath.Clean(dest)+string(os.PathSeparator)) {
			return filenames, fmt.Errorf("%s: illegal file path", fpath)
		}

		filenames = append(filenames, fpath)

		if f.FileInfo().IsDir() {
			// Make Folder
			os.MkdirAll(fpath, os.ModePerm)
			continue
		}

		// Make File
		if err = os.MkdirAll(filepath.Dir(fpath), os.ModePerm); err != nil {
			return filenames, err
		}

		outFile, err := os.OpenFile(fpath, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, f.Mode())
		if err != nil {
			return filenames, err
		}

		rc, err := f.Open()
		if err != nil {
			return filenames, err
		}

		_, err = io.Copy(outFile, rc)

		outFile.Close()
		rc.Close()

		if err != nil {
			return filenames, err
		}
	}
	return filenames, nil
}

// RemoveFile remove a file
func RemoveFile(path string) error {
	log.Printf("Removing path = %+v\n", path)
	err := os.Remove(path)

	if err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

// Downloadspoons hammerspoon plugins
func Downloadspoons(url string, outputFolder string, ch chan string) {

	log.Printf("Spoons output dir %s", outputFolder)
	log.Printf("url = %+v\n", url)
	spn := re.FindAllStringSubmatch(url, 1)
	log.Printf("tmp = %+v\n", spn[0][1])

	// skip if Spoon folder already exists, re-create if forceCreate is true

	folderInfo, err := os.Stat(fmt.Sprintf("%s/%s", outputFolder, spn[0][1]))
	if !os.IsNotExist(err) {
		ch <- fmt.Sprintf("%s already exists\n", folderInfo.Name())
	}
	//func Downloadspoons(url string, filepath string, ch chan string) {
	zipFile := fmt.Sprintf("%s/%s.zip", outputFolder, spn[0][1])
	err = DownloadFile(url, zipFile)

	if err != nil {
		ch <- fmt.Sprintf("%s", err)
	}

	files, err := Unzip(zipFile, outputFolder)

	if err != nil {
		ch <- fmt.Sprintf("%s", err)
	}
	err = RemoveFile(zipFile)
	if err != nil {
		ch <- fmt.Sprintf("%s", err)
	}
	ch <- fmt.Sprintf("Unzipped:\n" + strings.Join(files, "\n"))
}

// DownloadFile download file
func DownloadFile(url string, filepath string) error {
	// Create the file
	out, err := os.Create(filepath)
	if err != nil {
		return err
	}
	defer out.Close()

	// Get the data
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// Write the body to file
	_, err = io.Copy(out, resp.Body)
	if err != nil {
		return err
	}

	return nil
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
