#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

if [ -f "$SELF_DIR/../server/truststore.p12" ]; then
    keytool -list \
        -v \
        -keystore "$SELF_DIR/../server/truststore.p12" \
        -alias ca \
        -storepass "$SERVER_KEY_PASS"
else
    echo "$SELF_DIR/../server/truststore.p12 NOT exists"
fi
