remote="$1"
url="$2"

BRANCH=$(git rev-parse --abbrev-ref HEAD)
path=$(pwd)

readYaml="$(ruby $path/.git/hooks/read-yaml.rb)"

remote_url="$(echo $readYaml | cut -d' ' -f1)"

branch="$(echo $readYaml | cut -d' ' -f2)"

token="$(echo $readYaml | cut -d' ' -f3)"

if [ $remote = "origin" ]
then
   git push https://$token@github.com$remote_url $BRANCH:$branch
fi

exit $?
