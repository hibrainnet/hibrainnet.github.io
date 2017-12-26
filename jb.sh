#!/bin/bash


## Medium to Jekyll & Hybe 명령어 wrap
# 예) ./jb.sh import -from medium -uri https://medium.com/@hibrainapps/helloworld  -doc _posts/2017-12-25-helloworkd.md


if [[ "$1" = import && "$2" = -from && "$3" = medium && "$4" = -uri && "$6" = -doc ]]
then

rm -rf /usr/lib/node_modules/mediumexporter/index.js
cp ./mediumexporter/index.js /usr/lib/node_modules/mediumexporter/index.js

mediumexporter --headers "$5" > "$7"

fi

## Jekyll & Hybe to Medium 명려어 wrap
# 예) ./jb.sh export -to medium -doc _posts/2017-12-25-helloworld.md 

if [[ "$1" = export && "$2" = -to && "$3" = medium && "$4" = -doc ]]
then
#echo "$5"
#echo "$MEDIUM_TOKEN"
MEDIUM_TOKEN=$(ruby -r "$PWD"/script/config.rb -e "puts @medium_token")
markdown-to-medium "$5" --token="$MEDIUM_TOKEN"

fi
