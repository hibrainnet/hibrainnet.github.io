



body='{
"request": {
"branch":"source"
}}'






github_token="1ceeeb78bd7e84490f9d1f378147ea55eef5b7d2"
token="$(travis login --github-token $github_token && travis token)"
repo="Pgahye.github.io"
user="Pgahye"

curl -s -X POST \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Travis-API-Version: 3" \
 -H "Authorization: token $token" \
 -d "$body" \
 https://api.travis-ci.org/repo/$user%2F$repo/requests

