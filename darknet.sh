#!/bin/bash

# Create the directory to store the transcripts if it doesn't already exist
mkdir -p "Darknet Diaries Transcripts"

# Base URL
base_url="https://darknetdiaries.com/transcript/"

# Loop through the range of episode numbers
for i in $(seq 1 144); do
    echo "Processing episode $i..."

    # Construct the full URL
    url="${base_url}${i}/"

    # Fetch the page content
    content=$(curl -s "$url")

    # Extract the transcript using the start markers (either FULL TRANSCRIPT or START OF RECORDING) and the end marker (END OF RECORDING)
    transcript=$(echo "$content" | sed -n -e '/FULL TRANSCRIPT/,/END OF RECORDING/p' -e '/START OF RECORDING/,/END OF RECORDING/p')

    # Remove HTML tags, the start and end markers, and unnecessary newlines
    clean_transcript=$(echo "$transcript" | sed -e 's/<[^>]*>//g' -e 's/FULL TRANSCRIPT//' -e 's/START OF RECORDING//' -e 's/END OF RECORDING//' | sed '/^$/d')

    # Save the clean transcript to a file
    echo "$clean_transcript" > "Darknet Diaries Transcripts/episode_$i.txt"
    echo "Episode $i saved."
done

echo "All transcripts have been saved."
