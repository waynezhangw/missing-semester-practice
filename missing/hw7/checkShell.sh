#!/bin/bash
## Example: a typical script with several problems
for f in *.py
do
  grep -qi "hq.*mp3" "$f" \
    && echo -e "Playlist $f contains a HQ file in mp3 format"
done
