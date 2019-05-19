# combine-mp3
Bash scripts to combine MP3s and add tags

## Requirements
mp3wrap
mp3val
id3v2
  
## Explanation

#### combine.sh
Combine mp3s in current directory to a single mp3

#### combine-cds.sh
Combine mp3s subdirectories to mp3s and combine those to an final mp3

*Example:*
```
basedir
  -CD 01
    - File01.mp3
    - File02.mp3
  - CD 02
    - File01.mp3
    - File02.mp3
```
Running combine-cds.sh will result in the following files:
```
out
  - 0001.mp3            # File01.mp3 and File02.mp3 from directory CD 01
  - 0002.mp3            # File01.mp3 and File02.mp3 from directory CD 02
  - final.mp3           # 0001.mp3 and 0002.mp3
  - final_unfixed.mp3   # final.mp3 with unfixed errors (mp3val backup)
```

## Additional notes

You _have_ to edit the scripts before running. Change the MP3 Tags and change #UNCOMMENT_WHEN_READY="duh" to UNCOMMENT_WHEN_READY="duh"
