package sslinfo

import (
    "crypto/tls"
    "fmt"
    "time"
)

// GetCertificateDetails returns the SSL certificate details for the given host and port.
func GetCertificateDetails(host, port string) ([]string, error) {
    conn, err := tls.Dial("tcp", fmt.Sprintf("%s:%s", host, port), nil)
    if err != nil {
        return nil, err
    }
    defer conn.Close()

    certs := conn.ConnectionState().PeerCertificates
    if len(certs) > 0 {
        cert := certs[0]

        issuerOrg := "Unknown Organization"
        if len(cert.Issuer.Organization) > 0 {
            issuerOrg = cert.Issuer.Organization[0]
        }

        expiryDateFormatted := cert.NotAfter.Format("02/01/2006")
        daysLeft := time.Until(cert.NotAfter).Hours() / 24

        return []string{host, issuerOrg, expiryDateFormatted, fmt.Sprintf("%.0f", daysLeft)}, nil
    }
    return nil, fmt.Errorf("no certificates found")
}
