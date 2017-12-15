# Jekyll and hybe

Jekyll & Hybe는 프로젝트 관련 기술을 제공 및 공유하는 블로그이다. 

마크다운 방식과 호스팅 없이 사용할 수 있는 설치형 블로그 구축하는 것을 목표로 한다. 


## Getting Started





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



## Hook

Bitbucket 저장소에서 master브런치로 push할 때, Github 저장소의 source브런치에 push 작업이 실행되도록 설정한다.

1. Bitbucket저장소 경로에서 아래 명령어를 실행하여 push 될 github 저장소 URL을 추가한다.
        git remote add 사용자지정이름 github저장소URL

2. 저장소/hooks 디렉토리에 있는 pre-push파일을 hooks설정 디렉토리에 복사한다.
        cp 저장소/hooks/pre-push 저장소/.git/hooks/pre-push

3. 저장된 pre-push 파일의 권한을 확인한 후 모든 사용자가 실행가능한 x권한이 없으면 권한 설정을 해준다.
        chmod +x 저장소/hooks/pre-push

