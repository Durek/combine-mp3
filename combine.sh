#!/bin/bash

### EDIT THESE VARIABLES ###

# MP3 TAGS
_YEAR="2004"
_ALBUM="Die Zwerge"
_ARTIST="Markus Heitz"
_TITLE="Der Krieg der Zwerge"
_GENRE="Fantasy"

############################

mp3wrap output.mp3 *.mp3
id3v2 output_MP3WRAP.mp3 -y "$_YEAR" -A "$_ALBUM" -a "$_ARTIST" -t "$_TITLE" -g "$_GENRE"
mp3val -f output_MP3WRAP.mp3
mv output_MP3WRAP.mp3.bak output_MP3WRAP_unfixed.mp3
