---
layout: post
author: gh.park
title: "repository to repository"
date: 2017-12-22 17:58:11 +0900
tags: [연구노트, 인턴십, travis ]
category: [travis]
publication: 'gahye-blog'
license: 'public-domain'
permalink: /repository-to-repository
thumbnail:
comments : true

---

###  repository 파일 가지고 오기

P.github.io 저장소에서 push작업이 발생하는 동안 posts 저장소에 있는 posts 디렉토리를  P.github.io 저장소로 옮겨오는 작업이 필요했다.
P.github.io repository는 공개 되어지는 공간이기 때문에, 포스팅되는 자료들이 있는 posts 디렉토리를 다른 저장소에서 관리하여 다른 이용자들이 불편함을 줄일 수 있도록 하기 위해서다.


### travis 이용
posts저장소를 remote에 추가한뒤, fetch를 통해 posts디렉토리를 merge하는 방식이다.
/.travis.yml 파일에 다음과 같이 추가한다.

```yml
before_install:
- git remote add <remote저장소이름> https://<사용자id>:<github토큰값>@github.com/<posts 저장소>.git
- git fetch <remote저장소이름>
- sudo git merge <remote저장소이름>/<branch 이름>

```

### git hooks 이용
git에서 push나 commit하기 전에 작업을 실행할수 있도록, /.git/hooks 디렉토리에서 pre-push, pre-commit를 제공한다. push하기 전에 작업이 진행되어야 하므로 pre-push 파일에 다음과 같이 추가한다.


```sh

git remote add <remote저장소이름> https://<사용자id>:<github토큰값>@github.com/<posts 저장소>.git
git fetch <remote저장소이름>
sudo git merge <remote저장소이름>/<branch 이름>

```







### 참고자료
* [Customizing the Build](https://docs.travis-ci.com/user/customizing-the-build/)
* [How to resolve git's “not something we can merge” error](https://stackoverflow.com/questions/16862933/how-to-resolve-gits-not-something-we-can-merge-error)
* [Git merge single file from another repository into my own](https://stackoverflow.com/questions/23314805/git-merge-single-file-from-another-repository-into-my-own)
* [Authenticate with GitHub using token](https://stackoverflow.com/questions/18935539/authenticate-with-github-using-token)
* [리모트 저장소 이름변경 및 삭제하기]( https://mylko72.gitbooks.io/git/content/remote/remove.html)
