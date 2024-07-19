#!/usr/bin/bash env

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

openssl req -x509 \
  -newkey rsa:2048 \
  -sha512 \
  -subj "/CN=$SUBJ_CN/C=$SUBJ_C/ST=$SUBJ_ST/L=$SUBJ_L/O=$SUBJ_O/OU=$SUBJ_OU/UID=$SUBJ_UID/" \
  -utf8 \
  -days "$EXPIRE_DAYS" \
  -keyout "$SELF_DIR/../rootca-privatekey-pkcs8.pem" \
  -noenc \
  -out "$SELF_DIR/../rootca-cert-x509.pem"

if [ x"$DELETE_MID_PRODUCT" = "xtrue" ]; then
  true
fi
