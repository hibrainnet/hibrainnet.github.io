# Jekyll and hybe

Jekyll & Hybe는 프로젝트 관련 기술을 제공 및 공유하는 블로그이다.

마크다운 방식과 호스팅 없이 사용할 수 있는 설치형 블로그 구축하는 것을 목표로 한다.


## Getting Started

#### 특정 사용자만 master에서 commit, push 사용하기
1. /hooks 디렉토리에 있는 pre-commit, pre-push, push-block.sh 파일을 .git/hooks 디렉토리로 이동
2. /.config.yml에 git설정 추가


```
git:
  admins:
    - userid@hibrain.net
    - userid@gmail.com
```


#### 마크다운형태의 파일(.md) Medium에 업로드하기
Node.js의 markdown-to-medium패키지를 이용하므로, node.js가 설치되어있어야 함

설치되어있지 않다면 다음과 같이 설치:


```console
$sudo apt-get update && sudo apt-get -y upgrade
$curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
$sudo apt-get install -y nodejs
$npm -v        // 정상적으로 설치되면 npm버전을 확인할 수 있다.
```


1. markdown-to-medium패키지 설치
* [markdown-to-medium github URL](https://github.com/yoshuawuyts/markdown-to-medium)


```console
$npm install --global markdown-to-medium
```


2. Medium 계정과 연동하기 위해 settings의 get Intergration tokens을 생성

3. 사용방법
3.1. Medium에 업로드할 마크다운 파일의 yaml frontmatter에 medium 계정의 publication 이름 및 license등을 추가

```yaml
---
layout: post
title:  "반갑습니다."
date:   2017-12-07 13:58:11 +0900
categories: [jekyll, update]
tags: [jekyll]
publication: 'hi-blog'
license: 'public-domain'
---
```

license는 all-rights-reserved, cc-40-by, cc-40-by-nd, cc-40-by-sa, cc-40-by-nc, cc-40-by-nc-nd, cc-40-by-nc-sa, cc-40-zero, public-domain
에서 선택해야 함(Medium api 참고)
도움말은 markdown-to-medium -h 을 이용


 3.2 실행


```console
 $markdown-to-medium <md파일의 경로> --token="토큰값"
```


 2에서 생성한 get Intergration tokens을 input하여 실행
 (tokens값은 최초 실행시에만 input해줘도 됨)

#### Medium blog 마크다운형태로 저장하기
Node.js의 medium exporter패키지를 이용하므로, node.js가 설치되어있어야 함

1. medium exporter패키지 설치
* [Medium Exporter github URL](https://github.com/xdamman/mediumexporter)


```console
npm install -g mediumexporter
```


2. yaml frontmatter를 자동으로 추가하기 위해, /mediumexporter/index.js 파일을 /usr/lib/node_modules/mediumexporter/에 추가 (기존 index.js 삭제)


```yaml
---
layout: post
author: 600bdec36593
url: https://medium.com/@robbinscm/mayor-bill-de-blasio-gothamist-dnainfo-interview-cbce444ca421
date: Wed Dec 20 2017 00:28:23 GMT+0900 (DST)
tags: [New York, Mayor Bill De Blasio, Sanctuary Cities, Journalism, Inequality ]
---
```


 3. 사용방법
 마크다운 파일을 받을 디렉토리에서 명령어 실행

```console
$ mediumexporter --headers Medium 주소 > medium_post.md
$ mediumexporter --headers https://medium.com/@xdamman/my-10-day-meditation-retreat-in-silence-71abda54940e > medium_post.md

```

도움말은 mediumexporter -h 을 이용





Bitbucket저장소에서 master브런치로 push할 때, Github저장소의 source브런치에 push작업이 실행되도록 설정한다.
- _config.yml파일에서 pre-push hook변수에 자신의 환경설정에 맞는 값으로 설정한다.
    github_page :
        remote_url : 소스코드를 push 할 저장소의 URL
        remote_name : 등록되는 url의 remote 이름(default 값은 github로 설정)
        branch : 소스코드를 push 할 저장소의 branch 이름

- 저장소/hooks 디렉토리에 있는 pre-push파일을 hook설정 디렉토리에 복사한다.
    cp 저장소/hooks 저장소/.git/hooks


## Deployment

데이터베이스가 필요없고, 마크다운형태로 정적 HTML을 만들어내는 jekyll을 이용해서 개발한다.

github pages에서 제공해주는 무료 호스팅을 사용한다.  


## Built With
* [Jekyll](http://https://jekyllrb.com/)
* [git](https://github.com/)
* [Ruby](https://www.ruby-lang.org/ko/)



## Versioning
We use [Keep a CHANGELOG](http://keepachangelog.com/en/0.3.0/) for versioning.
- see the CHANGELOG.md file for details




## Authors
* **Hibrainnet Intern**




## License
This project is licensed under the MIT License - see the LICENSE.md file for details
