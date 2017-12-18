

branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
USER_EMAIL=$(git log -1 --format=format:%ae HEAD)
USER_NAME=$(git log -1 --format=format:%an HEAD)

ADMIN_GIT_EMAIL=$(ruby "$PWD"/script/config.rb "admin_git_email")

echo $PWD
echo $ADMIN_EMAIL
echo $USER_EMAIL

if [ "$branch" = master ];
then

    if [ "$USER_EMAIL" != "$ADMIN_GIT_EMAIL" ];
    then
        echo "-----------------------------------------------------"
        echo "WARNING: You are not allowed to Push/commit in MASTER branch !"
        echo "-----------------------------------------------------"
        exit 1
    fi
fi
