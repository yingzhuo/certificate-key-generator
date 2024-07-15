#!/usr/bin/bash env

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

if [ ! -f "$SELF_DIR/../root-ca.crt" ]; then
  echo "CA root files NOT exists"
  echo "abort ..."
  exit 0
fi

for name in $(eval echo "$CLIENT_NAMES")
do

  openssl req -new \
    -newkey rsa:2048 \
    -sha512 \
    -utf8 \
    -subj "/CN=$name/" \
    -outform PEM \
    -noenc \
    -keyout "$SELF_DIR/../client/client-$name.key" \
    -out "$SELF_DIR/../client/client-$name.csr"

  openssl x509 -req \
    -CA "$SELF_DIR/../root-ca.crt" \
    -CAcreateserial \
    -CAkey "$SELF_DIR/../root-ca.key" \
    -in "$SELF_DIR/../client/client-$name.csr" \
    -passin pass:"$CLIENT_KEY_PASS" \
    -out "$SELF_DIR/../client/client-$name.crt" \
    -days "$EXPIRE_DAYS"

  openssl pkcs12 -export \
    -out "$SELF_DIR/../client/client-$name.p12" \
    -passout pass:"$CLIENT_KEY_PASS" \
    -name "$name" \
    -inkey "$SELF_DIR/../client/client-$name.key" \
    -in "$SELF_DIR/../client/client-$name.crt" \
    -passin pass:"$CLIENT_KEY_PASS"

  if [ x"$DELETE_MID_PRODUCT" = "xtrue" ]; then
    rm -rf "$SELF_DIR/../client/client-$name.key"
    rm -rf "$SELF_DIR/../client/client-$name.csr"
    rm -rf "$SELF_DIR/../client/client-$name.crt"
  fi

done