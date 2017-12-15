

branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
USER_EMAIL=$(git log -1 --format=format:%ae HEAD)
USER_NAME=$(git log -1 --format=format:%an HEAD)


ADMIN_EMAIL=$(grep -w 'ADMIN_EMAIL:' "$PWD"/_config.yml | tail -n1 | cut -c 13- | tr -d ' ' )


echo $ADMIN_EMAIL
echo $USER_EMAIL

if [ "$branch" = master ];
then

    if [ "$USER_EMAIL" != "$ADMIN_EMAIL" ];
    then
        echo "-----------------------------------------------------"
        echo "WARNING: You are not allowed to Push/commit in MASTER branch !"
        echo "-----------------------------------------------------"
        exit 1
    fi
fi
