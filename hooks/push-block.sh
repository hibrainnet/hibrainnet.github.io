#!/bin/bash

branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
# USER_EMAIL=$(git log -1 --format=format:%ae HEAD)
# USER_NAME=$(git log -1 --format=format:%an HEAD)
USER_EMAIL=$(git config user.email)
USER_NAME=$(git config user.name)

#echo $PWD
ADMIN_LENGTH=$(ruby -r "$PWD"/script/config.rb -e "puts @admin_length")
ADMIN_GIT_EMAIL=$(ruby -r "$PWD"/script/config.rb -e "puts @admin_git_email")
EXIT="EXIT0"

#ADMIN_EMAIL=$(grep -A1 'git:' "$PWD"/_config.yml | tail -n1 | cut -c 13- | tr -d ' ' )
#echo $ADMIN_GIT_EMAIL
#echo $ADMIN_LENGTH
#echo $ADMIN_EMAIL
#echo $USER_EMAIL

for i in $ADMIN_GIT_EMAIL; do

    if [[ "$USER_EMAIL" = "$i" && "$branch" = master ]]
    then
       EXIT="EXIT1"  #스페이스 주의
    fi
    if [[ "$branch" != master ]]
    then

       EXIT="EXIT1"  
    fi
done

if [ "$EXIT" = EXIT0 ]; then
        echo "-----------------------------------------------------"
        echo "WARNING: You are not allowed to Push in MASTER branch !"
        echo "-----------------------------------------------------"
        exit 1
else
        exit 0
fi
