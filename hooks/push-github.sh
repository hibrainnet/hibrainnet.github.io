remote="$1"
url="$2"

BRANCH=$(git rev-parse --abbrev-ref HEAD)
path=$(pwd)

readYaml="$(ruby $path/hooks/read-yaml.rb)"

remote_url="$(echo $readYaml | cut -d' ' -f1)"
branch="$(echo $readYaml | cut -d' ' -f2)"
remote_name="$(echo $readYaml | cut -d' ' -f3)"

check="$(git remote get-url $remote_name)"
if [ "$check" ]:; then echo "$remote Pushing....."; else git remote add $remote_name $remote_url && echo "Add first $remote_name URL"; fi

if [ $remote = "origin" ]
then
   git push $remote_name $BRANCH:$branch
fi

exit $?
