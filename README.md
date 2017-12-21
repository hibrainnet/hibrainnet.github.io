# Jekyll and hybe

Jekyll & Hybe는 프로젝트 관련 기술을 제공 및 공유하는 블로그이다.

마크다운 방식과 호스팅 없이 사용할 수 있는 설치형 블로그 구축하는 것을 목표로 한다.


## Getting Started

특정 사용자 master commit, push 사용하기
- hooks 디렉토리에 있는 pre-commit, pre-push, push-block.sh 파일을 .git/hooks 디렉토리에 옮겨준다.


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

## Posts Paging

페이징 관련 변수는 _config.yml에 다음과 같이 존재한다.

_config.yml
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

**sort_field** - _posts에 작성된 게시물을 정렬할 기준 정의  

**sort_reverse** - 역순으로 정렬할지 여부 정의  




## Authors
* **Hibrainnet Intern**




## License
This project is licensed under the MIT License - see the LICENSE.md file for details
