#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

echo "input \"clean all\" to remove all generated files: "
read INPUT

# 防呆机制
if [ x"$INPUT" = "xclean all" ]; then
    rm -rf "$SELF_DIR/../client/"
    rm -rf "$SELF_DIR/../server/"
    rm -rf "$SELF_DIR/../jwt/"
    rm -rf "$SELF_DIR/../root-ca.crt"
    rm -rf "$SELF_DIR/../root-ca.key"
    rm -rf "$SELF_DIR/../root-ca.srl"
else
    echo "abort ..."
fi
