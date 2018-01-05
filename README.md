# Jekyll and hybe

**Jekyll & Hybe** 는 프로젝트 [Jekyll](https://jekyllrb.com/) 기반의 블로그 엔진이다.

## GitHub Pages 퍼블리싱 설정
Jekyll & Hybe는 GitHub 를 사용하여 GitHub Pages로 퍼블리싱하는 기능을 가지고 있다. github 가 아닌 다른 git 저장소에서 GitHub 로 자동으로 소스코드를 디플로이하여 GitHub Pages를 퍼블리싱할 수 있다.

- `hooks/` 디렉토리 안의 파일을 `.git/hooks/`  디렙토리 안으로 복사한다.
- `_config.yml` 파일에서 `github_pages:` 를 설정한다.
```
github_pages :
  remote_url : 접근하고자 하는 저장소의 /username/repository_name.git
  branchi : 소스코드를 push 할 저장소의 branch 이름
  token : 접근하고자 하는 저장소의 personal access token [github API](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) 참고
```

예)
```
github_pages:
  remote_url : /hibrainnet/jekyll-and-hybe.git
  branch: source
  token : ****************************************
```

## git 관리자 설정

Jekyll & Hybe 에서는 소스코드 관리를 제한하기 위해 git 관리자만 master 브랜치에 commit과 push 를 할 수 있는 기능을 가지고 있다. 이 기능을 같이 작업하는 다른 사용자가 소스코드를 master에 적용할 수 없도록 제한하여 소스코드의 품질을 관리할 때 필요한 기능이다. 이 기능을 사용하기 위해서는 다음과 같이 크게 두가지 설정을 해야한다.

- `hooks/` 디렉토리 안의 파일을 `.git/hooks/`  디렉토리 안으로 복사한다.
- `_config.yml` 파일 안에 있는 `git:`의 `admins:` 에 관리자 이메일 주소를 추가한다. 이 때 메일주소는 git에 사용하는 메일 주소를 입력한다. 관리자의 메일은 배열 형태로 여러개를 입력할 수 있다.
```
git:
  admins:
    - userid@hibrain.net
    - userid@gmail.com
```
git의 메일주소를 확인하고 싶으면 다음 명령어를 사용하여 확인 할 수 있다.
```
git config user.email
```

## travis build 설정

Jekyll & Hybe 에서는 Github-page에서 push가 일어나면 자동으로 프로젝트 빌드를 해주는 travis ci가 구축되어있다.
travis api로 구현된 ruby파일을 실행하면 push하지 않아도 사용자가 임의로 빌드를 발생할 수 있다. 이 기능을 사용하기 위해서는 다음과 같이 설정한 후 실행한다.

-`_config.yml` 파일 안에 있는 `travis:`의 `repository_path:`에 빌드를 발생시킬 저장소의 경로를 추가한다. 이 때 저장소의 경로는 travis에서의 저장도 경로를 추가해야한다.
-`_config.yml` 파일이 있는 경로에서 `ruby travis/travis-build.rb` 파일을 실행시킨다.

예)
```
travis:
  repository_path: hibrainnet/jekyll-and-hybe
```

## Inport 기능
Jekyll & Hybe는 다른 외부 블로그 서비스에서 글을 Import 하는 기능을 가지고 있다. Inport 할 수 있는 서비스는 다음과 같다.

- [Medium](https://www.medium.com)
- [Atlassian Confluence](https://www.atlassian.com/software/confluence)

### Medium to Jekyll & Hiby
**Medium to Jekyll & Hybe** 는 Medium의 글을 Jekyll & Hybe의 글로 임포트하는 기능이다.

```
./jb.sh import -from medium -uri https://medium.com/@hibrainapps/hello-world -doc _posts/2017-12-25-helloworkd.md

```
<br>
## Export 기능
Jekyll & Hybe는 다른 외부 블로그 서비스로 내가 쓴 글을 export 할 수 있는 기능을 가지고 있다. Export 할 수 있는 서비스는 다음과 같다.

- [Medium](https://www.medium.com)
- [Atlassian Confluence](https://www.atlassian.com/software/confluence)

### Jekyll & Hybe to Medium (Medium 에 export하기)
FrontMatter에 Medium 글 발행에 필요한 정보를 추가한다.
- **publication** : Medium 컬렉션 이름
- **license** : all-rights-reserved, cc-40-by, cc-40-by-nd, cc-40-by-sa, cc-40-by-nc, cc-40-by-nc-nd, cc-40-by-nc-sa, cc-40-zero, public-domain

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

FrontMatter 설정 후 다음 명령어를 실행한다. token은 [Medium Settings](https://medium.com/me/settings)에서 생성한 Medium Token 을 사용한다.

```
./jb.sh export -to medium -doc  _posts/2017-12-25-hello-world.md

```
<br>
## google Analytics 기능
Jekyll & Hybe는 google Analytics를 사용하여 웹 사이트를 추적하고 분석할 수 있다. 이 기능을 사용하기 위해서는 다음과 같이 설정을 해야한다.
- [google Analytics](https://www.google.com/analytics/)

### \_includes 디렉토리에 google-analytics.html 추적 코드 추가
```javascript

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', '{{ site.google_analytics }}', 'auto');
  ga('send', 'pageview');

</script>

```

### \_config.yml 파일에 Google 웹로그 분석 추적 ID 추가
```yml

# Google Analytics
google_analytics: UA—XXXXXXXX-X

```
### \_include디렉토리에 추적 코드 추가
웹사이트 방문시, 모두 올바르게 추적할 수 있도록  \_include디렉토리의 head.html에  </head> 태그 바로 앞에 다음과 같이 코드를 추가한다.
```yaml

{% if site.google_analytics and jekyll.environment == 'production' %}
{% include google-analytics.html %}
{% endif %}

```
<br>
## TRAVIS로 Markdown 저장소 가져오기
Jekyll & Hybe 는 공개 되어지는 공간이기 때문에, Markdown 형식의 post를 다른 저장소에서 관리하고 있다. 이 기능은 TRAVIS를 통해 배포할때 Markdown 형식의 post를 가지고 오는 기능이다.
### \_config.yml파일에 post를 저장할 저장소의 url 설정
```yml

## gitbub remote 설정
github_post:  ##post를 저장할 저장소의 url 설정
    remote_url: https://userid:sdwdwjfi2232bffff@github.com/user/Posts.git
    ## https://<사용자id>:<github토큰값>@github.com/<posts 저장소>.git
```
### .travis.yml파일 추가
\_config.yml의 github_post의 remote_url값을 이용하여 remote 저장소를 추가한다.
Markdown 형식의 post가 저장되어 있는 other/post를 merge한다.
```yml

before_install:
- GIT_POST_URL=$(ruby -r "$PWD"/script/config.rb -e "puts @github_post_url")
- git remote add other $GIT_POST_URL
- git fetch other
- git merge --no-edit other/post

```
<br>


## Posts Paging

페이징 관련 변수는 `_config.yml`에 다음과 같이 존재한다.

`_config.yml`
```
  pagination:
    type: numbering
    enabled: true
    per_page: 2
    permalink: '/page/:num'
    limit: 0
    sort_field: "date"
    sort_reverse: true
```

**type** - 페이징 방법을 정의
>simple - 이전 / 다음 버튼만 제공
numbering - 설정값에 따라 페이징 넘버 제공    

**enabled** - 페이징 기능을 사용할지 여부 정의 (true | false)  

**per_page** - 한 페이지에 보여줄 게시물의 개수  

**permalink** - 각 페이지가 가지는 url형식 정의  
> :num에 페이지 값이 할당

>permalink: '/page/:num' 인경우
3 페이지 = /page/3

>permalink: '/page:num' 인경우
3 페이지 = /page3

**limit** - 한 화면에 나타낼 페이질 개수 정의
> 0일 경우 unlimit (모든 페이징을 한 화면에 보여준다 )
 5인 경우 한 화면에 1~5, 6~10 처럼 5단위로 보여준다

**sort_field** - posts에 작성된 게시물을 정렬할 기준 정의  

**sort_reverse** - 역순으로 정렬할지 여부 정의  




## Comments
댓글 시스템은 disqus와 facebook을 이용하여 구현한다.
`_config.yml` 파일에서 Comments 변수 안에 disqus와 facebook 변수를 선언하여 각각 사용한다.
disqus shortname :
1. disqus에 회원가입 후 get start 버튼을 이용하여 설정
2. 메인메뉴에서 Admin 버튼클릭
3. 상단의 setting 버튼을 클릭하여 자신의 앱을 선택
4. Shortname을 확인

facebook app_id :  앱 ID를 찾으려면 https://developers.facebook.com 에서 찾을 수 있다.
1. 메인 화면에서 우측 상단의 내앱에 마우스 오버.
2. 사용 중인 앱을 클릭.
3. 앱 ID 확인.

facebook admin_id : admin_id는 페이스북 댓글 시스템을 관리하기 위해서 필요하다.
사용자 ID를 찾으려면 다음 단계를 따라야한다.
1. Facebook 오른쪽 상단에 있는 역삼각형 아이콘을 클릭하고 설정을 선택.
2. 왼쪽 열에서 앱을 클릭.
3. 앱 또는 게임에 커서를 가져간 다음 연필 모양 아이콘을 클릭.
4. 하단의 앱 개발자도움받기에서  사용자 ID 확인.

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
