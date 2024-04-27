#!/bin/bash

mkdir -p "Darknet Diaries Transcripts"

# Base URL
base_url="https://darknetdiaries.com/transcript/"

for i in $(seq 1 144); do
    echo "Processing episode $i..."

    url="${base_url}${i}/"

    content=$(curl -s "$url")

    transcript=$(echo "$content" | sed -n -e '/FULL TRANSCRIPT/,/END OF RECORDING/p' -e '/START OF RECORDING/,/END OF RECORDING/p')

    # Remove HTML tags, the start and end markers, and unnecessary newlines
    clean_transcript=$(echo "$transcript" | sed -e 's/<[^>]*>//g' -e 's/FULL TRANSCRIPT//' -e 's/START OF RECORDING//' -e 's/END OF RECORDING//' | sed '/^$/d')

    echo "$clean_transcript" > "Darknet Diaries Transcripts/episode_$i.txt"
    echo "Episode $i saved."
done

echo "All transcripts have been saved."
