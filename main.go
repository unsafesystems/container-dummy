package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		_, _ = w.Write([]byte("Hello, world!\n"))
	})

	err := http.ListenAndServe(":"+port, http.DefaultServeMux)
	if err != nil {
		log.Println(err)
	}
}
