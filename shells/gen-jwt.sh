#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

rm -rf "$SELF_DIR/../jwt/"
mkdir -p "$SELF_DIR/../jwt/"

openssl genrsa \
  -out "$SELF_DIR/../jwt/jwt-privatekey-pkcs8.pem" \
  2048

openssl req -new \
  -x509 \
  -sha384 \
  -subj "/CN=jwt/" \
  -key "$SELF_DIR/../jwt/jwt-privatekey-pkcs8.pem" \
  -out "$SELF_DIR/../jwt/jwt-cert-x509.pem" \
  -days "$EXPIRE_DAYS"

openssl pkcs12 \
  -export \
  -inkey "$SELF_DIR/../jwt/jwt-privatekey-pkcs8.pem" \
  -in "$SELF_DIR/../jwt/jwt-cert-x509.pem" \
  -name "$JWT_ALIAS" \
  -out "$SELF_DIR/../jwt/jwt.p12" \
  -passout pass:"$JWT_PASS"

if [ x"$DELETE_MID_PRODUCT" = "xtrue" ]; then
  rm -rf "$SELF_DIR/../jwt/jwt-privatekey-pkcs8.pem"
  rm -rf "$SELF_DIR/../jwt/jwt-cert-x509.pem"
fi
