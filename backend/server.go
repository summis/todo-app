package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"time"
)

var port = "8080"

func main() {
	fmt.Printf("Starting server on port: %s\n", port)

	http.HandleFunc("/", func(res http.ResponseWriter, req *http.Request) {
		http.ServeFile(res, req, "../frontend/index.html")
	})

	http.HandleFunc("/random_image/", func(res http.ResponseWriter, req *http.Request) {
		// Save current date to pictures name. Now we can simply check whether path
		// to today's file exist and download new image only in that case.
		now := time.Now().Format("2006-01-02")
		filename := "files/" + now + ".jpg"

		if _, err := os.Stat(filename); err != nil {
			err := downloadRandomImage(filename)
			if err != nil {
				log.Fatal(err)
			}
		}

		http.ServeFile(res, req, filename)
	})

	log.Fatal(http.ListenAndServe(":"+port, nil))
}

// Gets random image from api and saves it to place given as argument.
// If error occurs error is returned; otherwise nil.
func downloadRandomImage(filename string) error {
	response, err := http.Get("https://picsum.photos/400")
	if err != nil {
		return err
	}
	defer response.Body.Close()

	file, err := os.Create(filename)
	if err != nil {
		return err
	}
	defer file.Close()

	_, err = io.Copy(file, response.Body)
	if err != nil {
		return err
	}

	return nil
}
