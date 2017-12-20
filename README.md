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

## Comments
댓글 시스템은 disqus와 facebook을 이용하여 구현한다.
_config.yml 파일에서 Comments 변수 안에 disqus와 facebook 변수를 선언하여 각각 사용한다.
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
