#!/bin/bash

# Check if input is provided
if [ -z "$1" ]; then
  echo "Usage: $0 input_audio_file"
  exit 1
fi

# Input file from argument
INPUT="$1"

# Extract file extension and base name
EXT="${INPUT##*.}"
BASENAME="${INPUT%.*}"

# Get total duration in seconds
DURATION=$(ffmpeg -i "$INPUT" 2>&1 | grep "Duration" | awk '{print $2}' | tr -d ,)
TOTAL_SECONDS=$(echo "$DURATION" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
HALF_SECONDS=$(echo "$TOTAL_SECONDS / 2" | bc)

# First half
ffmpeg -i "$INPUT" -t "$HALF_SECONDS" -c copy "${BASENAME}_part1.${EXT}"

# Second half
ffmpeg -i "$INPUT" -ss "$HALF_SECONDS" -c copy "${BASENAME}_part2.${EXT}"
