#! /bin/sh

pwd=$(pwd)

echo '블로그 설정 저장소를 만들 사용자 이름을 입력해주세요'
read username

echo '마크다운 파일을 업로드 할 저장소 이름을 입력해주세요.'
read mdrepo

echo 'jekyll-and-hybe 엔진을 설정해줄 저장소 이름을 입력해주세요.'
read jekyllrepo

echo '블로그의 도메인 이름을 입력해주세요. \ ex)blog.username.net'
read domain


curl -i -u $username \
     -d '{"name": "'$mdrepo'", "auto_init": true}' \
     https://api.github.com/user/repos

curl -i -u $username \
     -d '{"name": "'$jekyllrepo'", "auto_init": false}' \
     https://api.github.com/user/repos

curl -i -u $username \
     -d '{"name": "'$username'.github.io", "auto_init": true}' \
     https://api.github.com/user/repos

git clone https://github.com/$username/$mdrepo.git

git clone https://github.com/$username/$jekyllrepo.git

cd $jekyllrepo
git pull https://github.com/hibrainnet/jekyll-and-hybe.git
rm CNAME

rm .travis.yml
rm _config.yml


echo "==================블로그와 관련된 설정을 시작합니다====================="


echo '블로그 이름을 입력해주세요.'
read title

echo '블로그에 노출시킬 트위터 계정명을 입력해주세요. 없으면 enter를 눌러주세요.'
read twitter

echo '블로그에 노출시킬 페이스북 계정명을 입력해주세요. 없으면 enter를 눌러주세요.'
read facebook

echo '블로그에 노출시킬 사용자의 이메일을 입력해주세요. 없으면 enter를 눌러주세요.'
read email


touch _config.yml

echo "## 사이트 설정
title: "$title"
twitter : https://twitter.com/"$twitter"
facebook : https://www.facebook.com/"$facebook"/
email: "$email"
description: >-

## git 설정
git:
  admins: ## admins에 등록된 사용자만 master에 commit, merge, push를 진행할 수 있음
    - sksong@hibrain.net
    - saltfactory@gmail.com


# Google Analytics
google_analytics:

## Medium tokens 설정
medium:
  integration_token:


## gitbub remote 설정
github_post:  ##post를 저장할 저장소의 url 설정
    remote_url: https://"$username":@github.com/"$username"/"$mdrepo".git



## github 설정
github_page:
  remote_url:
  branch:
  token:
  builder: travis

## travis를 이용한 github page 빌드 설정
travis:
  github_token:
  target_branch: master
  source_branch: source
  repository_path: "$username"/"$jekyllrepo"

## 소셜 서비스 계정
sns:
  twitter: 
  github: 
  medium: 

## 댓글 계정
comments:
  disqus:
    shortname:
  facebook:
    admin_id:
    app_id:

## 페이징 설정

pagination:
  type: numbering
  enabled: true
  per_page: 5 # 한 화면에 보여줄 post 갯수
  permalink: '/page/:num'
  limit: 0 # 한번에 보여줄 페이징 숫자
  sort_field: date
  sort_reverse: true

# 작성자 설정 (콜렉션)
collections:
  authors:
    output: true #독립적인 파일로 생성 하고 싶은경우 true
    permalink: /authors/:path #독릭적입 파일로 생겼을때 url

# 작성자 콜렉션에 대한 메타데이터
defaults:
  - scope:
      path: ''
      type: authors
    values:
      layout: author
# Jekyll 설정
markdown: kramdown
theme: minima
plugins:
  - jekyll-feed
  - jekyll-paginate-v2
  - jekyll-sitemap
  - jekyll-redirect-from
  - jekyll-compose
  - jekyll-seo-tag

include: ['_pages']

exclude:
  - vendor
  - Gemfile
  - Geffile.lock
  - LICENSE
  - README.md
  - Rakefile"  > _config.yml


echo "=============================travis build와 관련된 설정을 시작합니다.========================="

touch .travis.yml

echo "language: ruby
rvm:
- 2.3.1

before_install:
- GIT_POST_URL=\$(ruby -r "\$PWD"/script/config.rb -e \"puts @github_post_url\")
- git clone \$GIT_POST_URL
- cp research-notes/* _posts/
- ls -al _posts/

install:
- gem install rake
- bundle install
deploy:
  provider: pages
  skip_cleanup: true
  github_token: \$GITHUB_TOKEN
  local_dir: _site
  target_branch: master
  on:
    branch: source


after_success:
  - git clone https://github.com/$username/$username.github.io.git
  - cd $username.github.io
  - shopt -s extglob
  - rm -rf !(.git)
  - cd ..
  - cp -r _site/* $username.github.io/
  - cd $username.github.io
  - git add .
  - git commit -m \"deploy from travis\"
  - ls -al
  - git push https://\$GITHUB_TOKEN@github.com/$username/$username.github.io.git master
  - cd .." > .travis.yml


git add .
git commit -m 'first page'
git push origin master

cd ..
cd $mdrepo

echo "==========================마크다운 파일 저장소의 travis build 설정을 시작합니다.=================================="


mkdir posts
touch .travis.yml

echo "language: ruby
rvm:
- 2.3.1

before_install:
- git clone https://github.com/$username/$jekyllrepo.git
- cd $jekyllrepo
- rm .travis.yml
- cp -r * ../
- cd ..
- rm -rf $jekyllrepo
- mv posts/* _posts/
- ls -al
- cd _posts
- ls -al
- cd ..

install:
- gem install rake
- bundle install
deploy:
  provider: pages
  skip_cleanup: true
  github_token: \$GITHUB_TOKEN
  local_dir: _site
  target_branch: master
  on:
    branch: source


after_success:
  - ls -al
  - ls -al _site/
  - git clone https://github.com/$username/$username.github.io.git
  - cd $username.github.io
  - shopt -s extglob
  - rm -rf !(.git)
  - cd ..
  - cp -r _site/* $username.github.io/
  - cd $username.github.io
  - git add .
  - git commit -m \"deploy from travis\"
  - ls -al
  - git push https://\$GITHUB_TOKEN@github.com/$username/$username.github.io.git master
  - cd .." > .travis.yml

git add .
git commit -m 'postrepo travis config'
git push origin master
