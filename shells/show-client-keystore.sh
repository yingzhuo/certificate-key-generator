#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

for name in $(eval echo "$CLIENT_NAMES")
do
    if [ -f "$SELF_DIR/../client/client-$name.p12" ]; then
        keytool -list \
            -keystore "$SELF_DIR/../client/client-$name.p12" \
            -alias "$name" \
            -storepass "$CLIENT_KEY_PASS" \
            -keypass "$CLIENT_KEY_PASS" \
            -v
        
        echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    else
        echo "$SELF_DIR/../client/client-$name.p12 NOT exists"
    fi

done
