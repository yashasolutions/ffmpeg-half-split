# Audio Splitter

A simple bash script to split audio files into two equal parts.

## Description

This script takes an audio file as input and splits it into two parts of equal duration using FFmpeg. The output files are named with `_part1` and `_part2` suffixes.

## Prerequisites

- `ffmpeg` - for audio processing
- `ffprobe` - for getting audio duration (usually comes with ffmpeg)
- `bc` - for floating point calculations

### Installation on Ubuntu/Debian
```bash
sudo apt update
sudo apt install ffmpeg bc
```

### Installation on macOS
```bash
brew install ffmpeg bc
```

### Installation on Arch Linux
```bash
sudo pacman -S ffmpeg bc
```

## Usage

```bash
./audio-spliter.sh input_audio_file.mp3
```

### Examples

```bash
# Split an MP3 file
./audio-spliter.sh song.mp3

# Split a WAV file
./audio-spliter.sh recording.wav

# Split a file without extension
./audio-spliter.sh audiofile
```

## Output

The script creates two files:
- `filename_part1.ext` - First half of the audio
- `filename_part2.ext` - Second half of the audio

If the input file has no extension, the output files will also have no extension.

## Features

- Handles files with or without extensions
- Supports file names with spaces and special characters
- Error checking for file existence and duration parsing
- Uses stream copying for fast processing (no re-encoding)

## Error Handling

The script will exit with an error message if:
- No input file is provided
- The input file doesn't exist
- The audio duration cannot be determined
- Duration calculations fail

## License

This project is open source and available under the MIT License.
