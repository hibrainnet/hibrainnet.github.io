# Jekyll and hybe

**Jekyll & Hybe** 는 프로젝트 [Jekyll](https://jekyllrb.com/) , [GitHub Pages](https://pages.github.com/), [travis](https://travis-ci.org/)기반의 블로그 엔진이다.


## 설치  

### jekyll-and-hybe설치
jekyll-and-hybe는 블로그의 기능 및 전반적인 레이아웃 파일이 설정되어 있는 저장소다.
1. https://github.com/hibrainnet/jekyll-and-hybe 에서 **Fork** 버튼 클릭
2. fork할 저장소 계정 선택
3. Jekyll-and-hybe를 설치할 위치에서 git clone
4. [Jekyll](https://jekyllrb.com/) 설치

```
$ git clone https://github.com/hibrainnet/jekyll-and-hybe.git
$ gem install jekyll bundler
$ jekyll new Jekyll-and-hybe
$ cd Jekyll-and-hybe
$ bundle install

```

### research-note 설치
research-note는 마크다운 형태의 블로그 포스트를 관리하는 저장소다.
1. https://github.com/hibrainnet/research-notes 에서 **Fork** 버튼 클릭
2. fork할 저장소 계정 선택
3. research-notes를 설치할 위치에서 git clone

```
$ git clone https://github.com/hibrainnet/research-notes.git

```

### Repository 생성
Repository는 HTML파일을 관리하는 저장소이다.
1. git저장소를 생성할 계정 로그인
2. https://github.com 에서 New repository 클릭
3. Repository name 입력 후 Create repository 클릭
Repository name은 블로그 도메인으로 사용한다. 예) hibrainnet.github.io


### travisCI 연동
travisCI는 github에서 진행되는 오픈소스 프로젝트를 위한 지속적인 통합 서비스이다.
1. [Github access token](https://github.com/settings/tokens) 생성
* Settings -> Developer settings -> Personal access tokens -> Generate new token
2. 연동할 git 계정으로 [travisCI](https://jekyllrb.com/) 로그인
3. 연동할 Repository enable
4. Travis CI tocken 생성
* 1에서 생성한 Github access token을 이용하여 Travis CI tocken 생성한다.
* tocken이름은 .travis.yml 파일에 적힌  $GITHUB_TOKEN  이름과 일치해야 한다.



## 새 글 작성 및 배포(발행)
### 새 글 작성
새 글은 마크다운형식으로 작성한다.
1. research-note 디렉토리 및 \_posts 디렉토리에 yyyy-mm-dd-title.md 이름으로 파일을 생성
2. 파일 상단에 [FrontMatter](https://jekyllrb.com/docs/frontmatter/) 작성
* layout : post #레이아웃(필수)
* title : "title" #제목(필수)
* author: gd.hong  #필자(필수)
* date : YYYY-MM-DD HH:MM:SS #발행일(필수)
* permalink: /title #포스트 url(필수) 되도록 글의 title 또는 주제로 작성
* comments : true #블로그 댓글 유무(필수)
* thumbnail: http://image.fileslink.com/1234/image2017-12-26_14-31-10.png #메인 이미지url(선택)
* tags : [tag1, tag2, tag3, ...] #태그 목록(선택) 되도록 특수문자없이 영소문자,숫자,-,.(점)만 사용
* publication: 'hong-blog' #Medium 컬렉션 이름(선택)
* license : 'public-domain' #Medium 라이센스 (선택)

```yaml
---
layout: post
author: gd.hong
title: "title"
date: 2017-12-26 15:00:11
tags: [tag1, tag2, tag3]
publication: 'long-blog'
license: 'public-domain'
permalink: /title
thumbnail: http://image.fileslink.com/1234/image2017-12-26_14-31-10.png
comments : true
---

```

### 필자 등록
1. jekyll-and-hybe의 \_authors 디렉토리에 lastname.firstname.md 이름으로 필자 정보 파일 추가
* name : gd.hong #post의 author과 매칭(필수)
* title : 홍길동 #한글이름(필수)
* position : 하이브레인넷 인턴 #직급(필수)
* image : http://image.fileslink.com/1234/image2017-12-26_14-31-10.png  #author사진(선택)
2. 글 상단에 frontmatter 추가

```yaml
---
name: gd.hong
title: 홍길동
position : 하이브레인넷 인턴
image : http://image.fileslink.com/1234/image2017-12-26_14-31-10.png
---

```

### 배포(발행)
research-note 디렉토리에서,
1. Fork 동기화
2. git push

```yaml

$ git fetch origin
$ git merge origin/master
$ git init
$ git add .
$ commit -m "message"
$ git push origin master

```

## jekyll-and-hybe 기능
### GitHub Pages 퍼블리싱 설정
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

### git 관리자 설정

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

### travis build 설정

Jekyll & Hybe 에서는 Github-page에서 push가 일어나면 자동으로 프로젝트 빌드를 해주는 travis ci가 구축되어있다.
travis api로 구현된 ruby파일을 실행하면 push하지 않아도 사용자가 임의로 빌드를 발생할 수 있다. 이 기능을 사용하기 위해서는 다음과 같이 설정한 후 실행한다.

-`_config.yml` 파일 안에 있는 `travis:`의 `repository_path:`에 빌드를 발생시킬 저장소의 경로를 추가한다. 이 때 저장소의 경로는 travis에서의 저장도 경로를 추가해야한다.
-`_config.yml` 파일이 있는 경로에서 `ruby travis/travis-build.rb` 파일을 실행시킨다.

예)
```
travis:
  repository_path: hibrainnet/jekyll-and-hybe
```

### Import 기능
Jekyll & Hybe는 다른 외부 블로그 서비스에서 글을 Import 하는 기능을 가지고 있다. Import 할 수 있는 서비스는 다음과 같다.

- [Medium](https://www.medium.com)
- [Atlassian Confluence](https://www.atlassian.com/software/confluence)

#### Medium to Jekyll & Hiby
**Medium to Jekyll & Hybe** 는 Medium의 글을 Jekyll & Hybe의 글로 임포트하는 기능이다.

```
./jb.sh import -from medium -uri https://medium.com/@hibrainapps/hello-world -doc _posts/2017-12-25-helloworkd.md

```

### Export 기능
Jekyll & Hybe는 다른 외부 블로그 서비스로 내가 쓴 글을 export 할 수 있는 기능을 가지고 있다. Export 할 수 있는 서비스는 다음과 같다.

- [Medium](https://www.medium.com)
- [Atlassian Confluence](https://www.atlassian.com/software/confluence)

#### Jekyll & Hybe to Medium (Medium 에 export하기)
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

### google Analytics 기능
Jekyll & Hybe는 google Analytics를 사용하여 웹 사이트를 추적하고 분석할 수 있다. 이 기능을 사용하기 위해서는 다음과 같이 설정을 해야한다.
- [google Analytics](https://www.google.com/analytics/)

#### \_includes 디렉토리에 google-analytics.html 추적 코드 추가
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

#### \_config.yml 파일에 Google 웹로그 분석 추적 ID 추가
```yml

# Google Analytics
google_analytics: UA—XXXXXXXX-X

```
#### \_include디렉토리에 추적 코드 추가
웹사이트 방문시, 모두 올바르게 추적할 수 있도록  \_include디렉토리의 head.html에  </head> 태그 바로 앞에 다음과 같이 코드를 추가한다.
```yaml

{% if site.google_analytics and jekyll.environment == 'production' %}
{% include google-analytics.html %}
{% endif %}

```

### TRAVIS로 Markdown 저장소 가져오기
Jekyll & Hybe 는 공개 되어지는 공간이기 때문에, Markdown 형식의 post를 다른 저장소에서 관리하고 있다. 이 기능은 TRAVIS를 통해 배포할때 Markdown 형식의 post를 가지고 오는 기능이다.
#### \_config.yml파일에 post를 저장할 저장소의 url 설정
```yml

## gitbub remote 설정
github_post:  ##post를 저장할 저장소의 url 설정
    remote_url: https://userid:sdwdwjfi2232bffff@github.com/user/Posts.git
    ## https://<사용자id>:<github토큰값>@github.com/<posts 저장소>.git
```
#### .travis.yml파일 추가
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


### Posts Paging

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

### 다른 git으로 \_site deploy 하기
jekyll travis가 빌드를 끝내면 \_site 내 파일들만 다른 저장소로 deploy 할 수 있다.

`config.yml` 에서 다음과 같은 코드로 설정 할 수 있다.

`_config.yml`

```
after_success:
  - git clone https://github.com/저장소-소유자-깃허브계정/저장소이름.git
  - cd 저장소이름
  - shopt -s extglob
  - rm -rf !(.git)
  - cd ..
  - cp -r _site/* 저장소이름/
  - cd 저장소이름
  - git add .
  - git commit -m "커밋메시지"
  - ls -al
  - git push https://$GITHUB_TOKEN@github.com/저장소-소유자-깃허브계정/저장소이름.git master
  - cd ..

```

위의 과정은 블로그를 서비스 할 git저장소에 서비스 할 파일만 (.html .css 등) 저장하고 싶은 경우 사용할 수 있다.

after_success는 jekyll이 해석을 성공적으로 끝냈경우 뒤에 실행된다.

jekyll이 해석을 끝내면 push할 저장소를 clone한다.

clone후 `.git` 디렉토리를 제외하고 모두 지운다

jekyll이 번역한 `_site` 파일은 clone한 git에 copy한다

copy한 파일을 기준으로 add, commit push를 진행한다









### Comments
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


### Search
검색 시스템은 구글 맞춤검색을 이용하여 구현한다.

1. 검색 박스를 넣을 html파일에 아래와 같은 코드를 추가한다.

예)

```html
<form action="{{ site.url}}/결과값을 출력할 페이지 url">
	<input name="검색어 매개변수 이름" type="text" placeholser="Search...">
	<input type="hidden" name="filter" value="0" />
	<button>search</button>
</form>
```


2. [구글 맞춤검색 엔진](https://cse.google.co.kr/cse/all)에서 사용자가 [검색 엔진 생성 방법](https://developers.google.com/custom-search/docs/tutorial/introduction)으로 생성한 스크립트를 결과값을 출력할 html파일에 추가한다.

- 사용자가 직접 검색 박스와 결과값을 지정하고 싶다면 **검색엔진수정 -> 디자인 -> 검색결과만** 방법으로 검색 엔진을 생성한다.

예)

```javascript
<script>
  (function() {
    var cx = '사용자의 개인 인증 키';
    var gcse = document.createElement('script');
    gcse.type = 'text/javascript';
    gcse.async = true;
    gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(gcse, s);
  })();
</script>
<gcse:searchresults-only></gcse:searchresults-only>
```

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
