#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

if [ ! -f "$SELF_DIR/../rootca-cert-x509.pem" ]; then
  echo "CA root files NOT exists"
  echo "abort ..."
  exit 0
fi

cat << _EOF_ > "$SELF_DIR/../server/server.ext"
authorityKeyIdentifier    = keyid,issuer
basicConstraints          = CA:FALSE
subjectAltName            = @alt_names

[alt_names]
IP.1                      = 127.0.0.1
DNS.1                     = localhost
_EOF_

rm -rf "$SELF_DIR/../server/truststore.p12"

openssl req -new \
  -newkey rsa:2048 \
  -sha512 \
  -utf8 \
  -subj "/CN=$SUBJ_CN/C=$SUBJ_C/ST=$SUBJ_ST/L=$SUBJ_L/O=$SUBJ_O/OU=$SUBJ_OU/UID=$SUBJ_UID/" \
  -keyout "$SELF_DIR/../server/server-privatekey-pkcs8.pem" \
  -noenc \
  -out "$SELF_DIR/../server/server.csr"

openssl x509 -req \
  -CAcreateserial \
  -CA "$SELF_DIR/../rootca-cert-x509.pem" \
  -CAkey "$SELF_DIR/../rootca-privatekey-pkcs8.pem" \
  -in "$SELF_DIR/../server/server.csr" \
  -out "$SELF_DIR/../server/server-cert-x509.pem" \
  -days "$EXPIRE_DAYS" \
  -extfile "$SELF_DIR/../server/server.ext"

openssl pkcs12 -export \
  -out "$SELF_DIR/../server/server.p12" \
  -passout pass:"$SERVER_STORE_PASS" \
  -name "$SERVER_STORE_ALIAS" \
  -in "$SELF_DIR/../server/server-cert-x509.pem" \
  -inkey "$SELF_DIR/../server/server-privatekey-pkcs8.pem"

keytool -import -trustcacerts \
  -alias "$TRUST_STORE_ALIAS" \
  -file "$SELF_DIR/../rootca-cert-x509.pem" \
  -ext san=dns:localhost,ip:127.0.0.1 \
  -storetype PKCS12 \
  -keystore "$SELF_DIR/../server/truststore.p12" \
  -storepass "$TRUST_STORE_PASS" \
  -noprompt

rm -rf "$SELF_DIR/../rootca-cert-x509.srl"

if [ x"$DELETE_MID_PRODUCT" = "xtrue" ]; then
  rm -rf "$SELF_DIR/../server/server.csr"
  rm -rf "$SELF_DIR/../server/server.ext"
fi
