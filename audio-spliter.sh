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

# Get total duration in seconds using ffprobe
TOTAL_SECONDS=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$INPUT")

# Check if duration was successfully retrieved
if [ -z "$TOTAL_SECONDS" ] || [ "$TOTAL_SECONDS" = "N/A" ]; then
  echo "Error: Could not determine duration of '$INPUT'"
  exit 1
fi

# Calculate half duration
HALF_SECONDS=$(echo "scale=3; $TOTAL_SECONDS / 2" | bc -l)

# Validate the calculated duration
if [ -z "$HALF_SECONDS" ]; then
  echo "Error: Could not calculate half duration"
  exit 1
fi

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
