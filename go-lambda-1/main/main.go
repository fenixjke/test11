package main

import (
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(handler)
}

func handler() error {
	fmt.Println("log from first lambda olol")
	return nil
}
