#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

echo "input \"clean-all\" to remove all generated files: "
read INPUT

if [ x"$INPUT" = "xclean-all" ]; then
    rm -rf "$SELF_DIR/../client/"
    rm -rf "$SELF_DIR/../server/"
    rm -rf "$SELF_DIR/../jwt/"
    rm -rf "$SELF_DIR/../rootca-cert-x509.pem"
    rm -rf "$SELF_DIR/../rootca-cert-x509.srl"
    rm -rf "$SELF_DIR/../rootca-privatekey-pkcs8.pem"
else
    echo "abort ..."
fi
