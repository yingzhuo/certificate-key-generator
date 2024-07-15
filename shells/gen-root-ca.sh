#!/usr/bin/bash env

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

openssl req -x509 \
  -newkey rsa:2048 \
  -sha512 \
  -subj "/CN=$SUBJ_CN/C=$SUBJ_C/ST=$SUBJ_ST/L=$SUBJ_L/O=$SUBJ_O/OU=$SUBJ_OU/" \
  -utf8 \
  -days "$EXPIRE_DAYS" \
  -keyout "$SELF_DIR/../root-ca.key" \
  -passout pass:"$ROOT_CA_KEY_PASS" \
  -out "$SELF_DIR/../root-ca.crt"
