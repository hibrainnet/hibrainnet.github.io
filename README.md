# Jekyll and hybe

Jekyll & Hybe는 프로젝트 관련 기술을 제공 및 공유하는 블로그이다. 

마크다운 방식과 호스팅 없이 사용할 수 있는 설치형 블로그 구축하는 것을 목표로 한다. 


## Getting Started

- Hook : push나 commit등 특정 시점에 이벤트를 발생시켜 실행되도록 한다.

  **Hook의 종류**

  |     이름      |                    설명                    |
  | :---------: | :--------------------------------------: |
  | pre-commit  | commit할 때 가장 먼저 호출되는 hook  commit 메세지를 작성하기 전에 호출 |
  | post-commit | commit이 완료 된 후 실행되는 hook  넘겨 받는 매개변수가 없음 |
  |  pre-push   | git push 명령을 실행하면 동작  remote의 이름과 주소를 매개변수로 전달 받음 |
  | post-merge  |             merge가 끝나고 나서 실행             |

  <br>

특정 사용자 master commit, push 사용하기 

- hooks 디렉토리에 있는 pre-commit, pre-push, push-block.sh 파일을 .git/hooks 디렉토리에 옮겨준다. 

  <br>

  - Bitbucket저장소에서  master브런치로 push할 때 Github저장소의 source브런치에 push가 실행되도록 설정한다.

  - Bitbucket저장소에서 push할 때 이벤트를 발생시켜야하기 때문에 pre-push파일을 설정한다.

    - _config.yml파일에서 pre-push hook변수에 자신의 환경설정에 맞는 값으로 설정한다.

        **github_page:**

        | 변수명         | 의미                                 |
        | ----------- | ---------------------------------- |
        | remote_url  | 소스코드를 push 할 저장소의 URL              |
        | remote_name | 등록되는 url의 remote 이름(기본 값 : github) |
        | branch      | 소스코드를 push 할 저장소의 branch 이름        |

        <br>

    - 저장소/hooks 디렉토리에 있는 pre-push파일을 Hook설정 디렉토리에 복사한다.

        <pre><code>cp 저장소/hooks 저장소/.git/hooks</code></pre>

  ​


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
