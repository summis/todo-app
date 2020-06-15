package main

import (
  "fmt"
  "net/http"
)

var port = "8080"

func main() {
  fmt.Printf("Starting server on port: %s\n", port)
  http.HandleFunc("/", Serve)
  http.ListenAndServe(":" + port, nil)
}

func Serve(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "Starting server on port: %s\n", port)
}
