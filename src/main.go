package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", HelloEndpoint)
	log.Println("Server started on port 8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("Error starting server: ", err)
	}
}

func HelloEndpoint(w http.ResponseWriter, r *http.Request) {
	greeting := os.Getenv("HELLO")
	if greeting == "" {
		greeting = "Hello"
	}
	response := fmt.Sprintf("%s, %s!", greeting, r.URL.Path[1:])
	fmt.Fprint(w, response)
	log.Printf("Responded to request at %s with: %s\n", r.URL.Path, response)
}
