#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

if [ -f "$SELF_DIR/../server/server.p12" ]; then
    keytool -list \
        -v \
        -keystore "$SELF_DIR/../server/server.p12" \
        -alias server \
        -storepass "$SERVER_KEY_PASS" \
        -keypass "$SERVER_KEY_PASS"
else
    echo "$SELF_DIR/../server/server.p12 NOT exists"
fi
