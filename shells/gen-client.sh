#!/usr/bin/bash env

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

if [ ! -f "$SELF_DIR/../rootca-cert-x509.pem" ]; then
  echo "CA root files NOT exists"
  echo "abort ..."
  exit 0
fi

for name in $(eval echo "$CLIENT_NAMES")
do

  openssl req -new \
    -newkey rsa:1024 \
    -sha512 \
    -utf8 \
    -subj "/CN=$name/" \
    -outform PEM \
    -noenc \
    -keyout "$SELF_DIR/../client/client-$name-privatekey-pkcs8.pem" \
    -out "$SELF_DIR/../client/client-$name.csr"

  openssl x509 -req \
    -CAcreateserial \
    -CA "$SELF_DIR/../rootca-cert-x509.pem" \
    -CAkey "$SELF_DIR/../rootca-privatekey-pkcs8.pem" \
    -in "$SELF_DIR/../client/client-$name.csr" \
    -out "$SELF_DIR/../client/client-$name-cert-x509.pem" \
    -days "$EXPIRE_DAYS"

  openssl pkcs12 -export \
    -out "$SELF_DIR/../client/client-$name.p12" \
    -passout pass:"$CLIENT_STORE_PASS" \
    -name "$name" \
    -inkey "$SELF_DIR/../client/client-$name-privatekey-pkcs8.pem" \
    -in "$SELF_DIR/../client/client-$name-cert-x509.pem"

  rm -rf "$SELF_DIR/../rootca-cert-x509.srl"

  if [ x"$DELETE_MID_PRODUCT" = "xtrue" ]; then
    rm -rf "$SELF_DIR/../client/client-$name.csr"
  fi

done