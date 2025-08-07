#!/bin/bash

# Check if input is provided
if [ -z "$1" ]; then
  echo "Usage: $0 input_audio_file"
  exit 1
fi

# Input file from argument
INPUT="$1"

# Check if file exists
if [ ! -f "$INPUT" ]; then
  echo "Error: File '$INPUT' not found"
  exit 1
fi

# Extract file extension and base name
if [[ "$INPUT" == *.* ]]; then
  EXT="${INPUT##*.}"
  BASENAME="${INPUT%.*}"
else
  EXT=""
  BASENAME="$INPUT"
fi

# Get total duration in seconds
DURATION=$(ffmpeg -i "$INPUT" 2>&1 | grep "Duration" | awk '{print $2}' | tr -d ,)
TOTAL_SECONDS=$(echo "$DURATION" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
HALF_SECONDS=$(echo "$TOTAL_SECONDS / 2" | bc)

# First half
if [ -n "$EXT" ]; then
  ffmpeg -i "$INPUT" -t "$HALF_SECONDS" -c copy "${BASENAME}_part1.${EXT}"
else
  ffmpeg -i "$INPUT" -t "$HALF_SECONDS" -c copy "${BASENAME}_part1"
fi

# Second half
if [ -n "$EXT" ]; then
  ffmpeg -i "$INPUT" -ss "$HALF_SECONDS" -c copy "${BASENAME}_part2.${EXT}"
else
  ffmpeg -i "$INPUT" -ss "$HALF_SECONDS" -c copy "${BASENAME}_part2"
fi
