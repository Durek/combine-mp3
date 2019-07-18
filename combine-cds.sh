#!/bin/bash

# Expected file tree:
# DIR 01
#  - File 01.mp3
#  - File 02.mp3
# DIR 02
#  - File 01.mp3
#  - File 02.mp3
# DIR 03
#  - File 01.mp3
#  - File 02.mp3
#
# Directories and files don't have to follow this name pattern, but must be sorted correctly by bash
# You should be good to go if "ls" shows them in the right order

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


# Check for dependencies
if [ ! `command -v mp3wrap` ] ; then
        echo "mp3wrap missing"
        exit 1
fi
if [ ! `command -v id3v2` ] ; then
        echo "id3v2 missing"
        exit 1
fi
if [ ! `command -v mp3val` ] ; then
        echo "mp3val missing"
        exit 1
fi


_BASEDIR=$(pwd)

if [ -z ${UNCOMMENT_WHEN_READY+x} ]; then
        echo -e "\e[1;41m Error: Change variables before running! \e[0m"
        exit 1
fi

rm -r "$_BASEDIR/out"
mkdir "$_BASEDIR/out"

COUNTER=1
for d in CD*/; do
        _d=$(printf %q "$d")
        num=`printf "%04d\n" $COUNTER`
        echo -e "\n\n\e[1;104m Merging: $_d \e[0m\n"
        cd "$_BASEDIR/$d"

        if [ -f "out_MP3WRAP.mp3" ]; then
                rm out_MP3WRAP.mp3
        fi

        mp3wrap out.mp3 *.mp3
        mv out_MP3WRAP.mp3 "$_BASEDIR/out/$num.mp3"
        COUNTER=$((COUNTER + 1))
done

cd "$_BASEDIR/out"

echo -e "\n\n\e[1;45m Merging: final \e[0m\e[49m\n"
mp3wrap final.mp3 *.mp3
mv final_MP3WRAP.mp3 final.mp3

echo -e "\n\n\e[1;45m Setting tags \e[0m\e[49m\n"
id3v2 final.mp3 -y "$_YEAR" -A "$_ALBUM" -a "$_ARTIST" -t "$_TITLE" -g "$_GENRE" -T "$_TRACKNUM"

echo -e "\n\e[1;45m Fixing errors \e[0m\e[49m"
echo "  - Log: $_BASEDIR/out/mp3val.log"
mp3val -f final.mp3 > mp3val.log
mv final.mp3.bak final_unfixed.mp3

echo -e "\n\e[1;42m Output directory: \e[0m\e[49m"
echo -e "  $_BASEDIR/out"
