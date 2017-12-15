




branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
USER_EMAIL=$(git log -1 --format=format:%ae HEAD)
USER_NAME=$(git log -1 --format=format:%an HEAD)

#echo $USER_NAME
#echo $branch

if [ "$branch" = HBNINTERN-24-master-branch-pre-hooks ];
then

    if [ "$USER_EMAIL" != rkgp05151@gmail.com ];
    then
        echo "-----------------------------------------------------"
        echo "WARNING: You are not allowed to Push in MASTER branch !"
        echo "-----------------------------------------------------"
        exit 1
    fi
fi
