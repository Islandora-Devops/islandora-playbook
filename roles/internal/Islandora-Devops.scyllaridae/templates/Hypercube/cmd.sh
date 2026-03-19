#!/usr/bin/env bash

set -eou pipefail

SOURCE_EXT="$1"
ARGS=()
if [ "$#" -gt 1 ]; then
  ARGS=("${@:2}")
fi

TMP_DIR=$(mktemp -d)

cleanup() {
  rm -rf "$TMP_DIR"
}

trap cleanup EXIT

INPUT="stdin"
if [ "$SOURCE_EXT" = "jp2" ]; then
  TMP_JP2="$TMP_DIR/input.jp2"
  cat > "$TMP_JP2"
  INPUT="$TMP_JP2"
  DEPTH=$(identify -format "%[bit-depth]" "$TMP_JP2" 2>/dev/null || echo "8")
  if [ "$DEPTH" = "16" ]; then
    TEMP_8BIT="$TMP_DIR/input.png"
    magick "$TMP_JP2" -depth 8 "$TEMP_8BIT"
    INPUT="$TEMP_8BIT"
  fi
fi

tesseract "$INPUT" stdout "${ARGS[@]}"
