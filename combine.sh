#!/bin/bash

### EDIT THESE VARIABLES ###

# Uncomment to make script work
#UNCOMMENT_WHEN_READY="duh"

# MP3 TAGS
_YEAR="2004"
_ALBUM="Die Zwerge"
_ARTIST="Markus Heitz"
_TITLE="Der Krieg der Zwerge"
_GENRE="Fantasy"
_TRACKNUM="1"

############################


if [ -z ${UNCOMMENT_WHEN_READY+x} ]; then
        echo -e "\e[1;41m Error: Change variables before running! \e[0m"
        exit 1
fi

mp3wrap output.mp3 *.mp3
id3v2 output_MP3WRAP.mp3 -y "$_YEAR" -A "$_ALBUM" -a "$_ARTIST" -t "$_TITLE" -g "$_GENRE" -T "$_TRACKNUM"
mp3val -f output_MP3WRAP.mp3
mv output_MP3WRAP.mp3.bak output_unfixed.mp3
mv output_MP3WRAP.mp3 output.mp3
