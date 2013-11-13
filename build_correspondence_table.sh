#!/usr/bin/env bash
echo '{|  class=wikitable
|-
! scope="col" | hex value
! scope="col" | IANA
! scope="col" | OpenSSL
! scope="col" | GnuTLS'
for orig in $(cat IANA_TLS_Names.csv)
do
    hexval1=$(echo $orig|cut -d ',' -f1)
    hexval2=$(echo $orig|cut -d ',' -f2)
    iana_name=$(echo $orig|cut -d ',' -f3)
    openssl_name=$(openssl ciphers -V | grep -i "$hexval1,$hexval2"|awk '{print $3}')
    gnutls_name=$(gnutls-cli -l | grep -i "$hexval1, $hexval2"|awk '{print $1}')
    echo "|-"
    echo "! scope="row" | $hexval1,$hexval2"
    echo "| $iana_name"
    echo "| $openssl_name"
    echo "| $gnutls_name"
done
echo "|}"
