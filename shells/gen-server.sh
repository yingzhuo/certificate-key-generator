#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

if [ ! -f "$SELF_DIR/../root-ca.crt" ]; then
  echo "CA root files NOT exists"
  echo "abort ..."
  exit 0
fi

cat << _EOF_ > "$SELF_DIR/../server/server.ext"
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
subjectAltName=@alt_names

[alt_names]
IP.1=127.0.0.1
DNS.1=localhost
_EOF_

rm -rf "$SELF_DIR/../server/truststore.p12"

openssl req -new \
  -newkey rsa:2048 \
  -sha512 \
  -utf8 \
  -subj "/CN=$SUBJ_CN/C=$SUBJ_C/ST=$SUBJ_ST/L=$SUBJ_L/O=$SUBJ_O/OU=$SUBJ_OU/" \
  -keyout "$SELF_DIR/../server/server.key" \
  -passout pass:"$SERVER_KEY_PASS" \
  -out "$SELF_DIR/../server/server.csr"

openssl x509 -req \
  -CA "$SELF_DIR/../root-ca.crt" \
  -CAkey "$SELF_DIR/../root-ca.key" \
  -in "$SELF_DIR/../server/server.csr" \
  -passin pass:"$SERVER_KEY_PASS" \
  -out "$SELF_DIR/../server/server.crt" \
  -days "$EXPIRE_DAYS" \
  -CAcreateserial \
  -extfile "$SELF_DIR/../server/server.ext"

openssl pkcs12 -export \
  -out "$SELF_DIR/../server/server.p12" \
  -passout pass:"$SERVER_KEY_PASS" \
  -name server \
  -in "$SELF_DIR/../server/server.crt" \
  -inkey "$SELF_DIR/../server/server.key" \
  -passin pass:"$SERVER_KEY_PASS"

keytool -import -trustcacerts \
  -alias "$TRUST_ALIAS" \
  -file "$SELF_DIR/../root-ca.crt" \
  -ext san=dns:localhost,ip:127.0.0.1 \
  -storetype PKCS12 \
  -keystore "$SELF_DIR/../server/truststore.p12" \
  -storepass "$TRUST_STORE_PASS" \
  -noprompt

if [ x"$DELETE_MID_PRODUCT" = "xtrue" ]; then
  rm -rf "$SELF_DIR/../server/server.key"
  rm -rf "$SELF_DIR/../server/server.crt"
  rm -rf "$SELF_DIR/../server/server.csr"
  rm -rf "$SELF_DIR/../server/server.ext"
fi
