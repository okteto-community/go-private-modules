package main

import (
	"fmt"
	"net/http"

	"github.com/mnevadom/go-private/pkg/test"
)

type report struct {
	License string `json:"license"`
}

func main() {
	fmt.Println("Starting hello-world server...")
	http.HandleFunc("/", helloServer)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}

func helloServer(w http.ResponseWriter, r *http.Request) {
	s := test.GetString()
	fmt.Fprint(w, "Hello world! - "+s)
}
