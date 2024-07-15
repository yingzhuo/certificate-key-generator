#!/usr/bin/env bash

SELF_DIR="$(dirname $0)"
source "$SELF_DIR/env.sh"

rm -rf "$SELF_DIR/../client/"
rm -rf "$SELF_DIR/../server/"
rm -rf "$SELF_DIR/../jwt/"