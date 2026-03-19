#!/usr/bin/env bash

set -eou pipefail

SOURCE_EXT="$1"
DESTINATION_EXT="$2"
ARGS=()
if [ "$#" -gt 2 ]; then
  ARGS=("${@:3}")
fi

TMP_DIR=$(mktemp -d)
INPUT_FILE="$TMP_DIR/input.$SOURCE_EXT"
OUTPUT_FILE="$TMP_DIR/output.$DESTINATION_EXT"

cleanup() {
  rm -rf "$TMP_DIR"
}

trap cleanup EXIT
cat > "$INPUT_FILE"

if [ "$DESTINATION_EXT" = "mp4" ]; then
  cmd=(
    ffmpeg -loglevel error
    -f "$SOURCE_EXT"
    -i "$INPUT_FILE"
    "${ARGS[@]}"
    -vcodec libx264
    -preset medium
    -acodec aac
    -strict -2
    -ab 128k
    -ac 2
    -async 1
    -movflags faststart
    -y
    -f "$DESTINATION_EXT"
    "$OUTPUT_FILE"
  )
  "${cmd[@]}" > /dev/null
elif [ "$DESTINATION_EXT" = "jpg" ] || [ "$DESTINATION_EXT" = "png" ]; then
  cmd=(
    ffmpeg -loglevel error
    -f "$SOURCE_EXT"
    -i "$INPUT_FILE"
  )

  if [[ "$SOURCE_EXT" =~ ^(mp3|wav|flac|aac|ogg|m4a)$ ]]; then
    cmd+=(-filter_complex "showwavespic=colors=#FFC627" -frames:v 1)
  fi

  cmd+=(
    "${ARGS[@]}"
    -f image2pipe
    -vcodec "${DESTINATION_EXT/#jpg/mjpeg}"
    "$OUTPUT_FILE"
  )
  "${cmd[@]}" > /dev/null
else
  cmd=(
    ffmpeg -loglevel error
    -f "$SOURCE_EXT"
    -i "$INPUT_FILE"
    "${ARGS[@]}"
    -y
    -f "$DESTINATION_EXT"
    "$OUTPUT_FILE"
  )
  "${cmd[@]}" > /dev/null
fi

if [ ! -s "$OUTPUT_FILE" ]; then
  exit 1
fi

cat "$OUTPUT_FILE"
