remote="$1"
url="$2"

BRANCH=$(git rev-parse --abbrev-ref HEAD)
path=$(pwd)

readYaml="$(ruby $path/hooks/read-yaml.rb)"

gitURL="$(echo $readYaml | cut -d' ' -f1)"
gitBranch="$(echo $readYaml | cut -d' ' -f2)"
gitRemoteName="$(echo $readYaml | cut -d' ' -f3)"

check="$(git remote get-url $gitRemoteName)"
if [ "$check" ]:; then echo "$remote Pushing....."; else git remote add $gitRemoteName $gitURL && echo "Add first $gitRemoteName URL"; fi

if [ $remote = "origin" ]
then
   git push $gitRemoteName $BRANCH:$gitBranch
fi

exit $?
