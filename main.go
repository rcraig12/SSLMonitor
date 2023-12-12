package main

import (
    "fmt"
    "sslinfo"
)

func main() {
    host := "www.microsoft.com"
    port := "443"

    details, err := sslinfo.GetCertificateDetails(host, port)
    if err != nil {
        fmt.Println("Error:", err)
        return
    }

		fmt.Printf("Host: %s\n", details[0])
    fmt.Printf("Issuer: %s\n", details[1])
    fmt.Printf("Expiry Date: %s\n", details[2])
    fmt.Printf("Days left until expiration: %s\n", details[3])
}
