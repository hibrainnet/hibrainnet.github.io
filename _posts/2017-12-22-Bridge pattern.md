---
layout: post
author: gh.park
title: "Bridge pattern"
date: 2017-12-22 17:58:11 +0900
tags: [연구노트, 인턴십, javapattern]
category: [디자인패턴]
publication: 'gahye-blog'
license: 'public-domain'
---

### 연구내용

#### Bridge 패턴 - 기능의 계층과 구현의 계층을 분리한다.
기능의 클래스 계층(추상화 부분)과 구현 클래스 계층을 분리하여 각자 독립적으로 변형할 수 있는 패턴이다.

기능과 구현을 각각 정의한 후, 구현에 관련된 클래스를 기능 클래스가 포함하는 구조이다.

기능과 구현이 분리된 것을 알 수 있고, 구현을 숨길수 있다는 장점이 있다.



예) 입력된 문자열을 출력해주는 프로그램이다.

hello, korea라는 문자열을

+------------+
:Hello, korea:
+------------+

위와 같은 형식으로 출력해준다.

다음과 같이 원하는 횟수만큼 출력도 할 수 있다.

+----------------+
:Hello, Universe.:
:Hello, Universe.:
:Hello, Universe.:
:Hello, Universe.:
:Hello, Universe.:
+----------------+
![1](https://media-api.atlassian.io/file/a68b0317-68de-472b-9946-bae2df7c4095/image?token=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1ZDBiZWYwMC0yZmQ5LTRlMDgtYmE2Ni1iNmQwMjVjZTE4NzYiLCJhY2Nlc3MiOnsidXJuOmZpbGVzdG9yZTpmaWxlOmE2OGIwMzE3LTY4ZGUtNDcyYi05OTQ2LWJhZTJkZjdjNDA5NSI6WyJyZWFkIl19LCJleHAiOjE1MTQyNTM3MTEsIm5iZiI6MTUxNDI1MDY1MX0.hykHV2cJrTjSDZhjdBhSBbjpZRIBddNLygyemL1RiZY&client=5d0bef00-2fd9-4e08-ba66-b6d025ce1876&name=image2017-12-14_16-13-1.png&max-age=2940&width=500&height=262)
![2](https://media-api.atlassian.io/file/ba433a24-8163-49d6-bf79-8f824dbd457c/image?token=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1ZDBiZWYwMC0yZmQ5LTRlMDgtYmE2Ni1iNmQwMjVjZTE4NzYiLCJhY2Nlc3MiOnsidXJuOmZpbGVzdG9yZTpmaWxlOmJhNDMzYTI0LTgxNjMtNDlkNi1iZjc5LThmODI0ZGJkNDU3YyI6WyJyZWFkIl19LCJleHAiOjE1MTQyNTM3MTEsIm5iZiI6MTUxNDI1MDY1MX0.i2R8ab04zjYYW6n7hACBCgWo6Bcph7p2CApKhMtdjI0&client=5d0bef00-2fd9-4e08-ba66-b6d025ce1876&name=image2017-12-13_18-27-26.png&max-age=2940&width=500&height=315)


##### Display 클래스 (표시하는 기능을 나타냄) 
추상적인 무언가를 표시하기 위한 것으로, 기능의 클래스의 최상위에 있는 클래스이다. 

impl필드는 클래스의 구현을 나타내기 위한 인스턴스이다. 

Display 의 생성자에게 구현을 나타내는 클래스의 인스턴스를 넘겨줌으로써, 처리된다. 

이 필드가 구현과 기능 클래스 계층사이의 다리 역할을 수행한다. 


```java

public class Display {
    private DisplayImpl impl;

    public Display(DisplayImpl impl) {
        this.impl = impl;
    }

    public void open() {        // 표시하기 전처리 단계
        impl.rawOpen();
    }

    public void print() {        // 표시
        impl.rawPrint();
    }

    public void close() {        // 표시 후처리
        impl.rawClose();
    }

    public final void display() {
        open();
        print();
        close();
    }
}

```

##### CountDisplay 클래스(지정횟수만큼 표시한다라는 기능을 나타냄)
Display클래스에 기능을 추가한 클래스이다. Display 클래스로부터 상속받은 메소드를 사용해서 새로운 메소드를 추가하고 있다. 


```java


public class CountDisplay extends Display {
    public CountDisplay(DisplayImpl impl) {
        super(impl);
    }

    public void multiDisplay(int times) {        // times번 반복하여 표시한다.
        open();
        for(int i = 0; i < times; i++ ) {
            print();
        }
        close();
    }
}

```

##### DisplayImpl 클래스

구현의 클래스 계층의 최상위로,Display 클래스의 open, print, close에 대응하는 rawOpen, rawPrint, rawClose 메소드를 가지고 있다.

```java

public abstract class DisplayImpl {
    public abstract void rawOpen();
    public abstract void rawPrint();
    public abstract void rawClose();
}

```

##### StringDisplayImpl 클래스
실제로 문자열 표시를 구현하고 있는 클래스

```java


public class StringDisplayImpl extends DisplayImpl {
    private String string;
    private int width;

    public StringDisplayImpl(String string) {
        this.string = string;
        this.width = string.getBytes().length;
    }

    @Override
    public void rawOpen() {
        printLine();
    }

    @Override
    public void rawPrint() {
        System.out.println(":" + string + ":");
    }

    @Override
    public void rawClose() {
        printLine();
    }

    private void printLine() {
        System.out.print("+");
        for(int i = 0; i < width; i++){
            System.out.print("-");
        }
        System.out.println("+");
    }
}

```

##### Main 클래스
변수 d1에는 Display 클래스의 인스턴스를 대입, d2,d3에는 CountDisplay 클래스의 인스턴스를 대입하고 있다. (기능)  

둘다 구현은 StringDisplayImpl  클래스의 인스턴스가 담당하고 있다. 

d1,d2,d3 모두 Display 클래스의 인스턴스의 일종이기 때문에 display 메소드를 호출할수 있으며, d3는 추가적으로 multiDisplay메소드도 호출할 수 있다. 

```java

public class Main {
    public static void main(String[] args) {
        Display d1 = new Display(new StringDisplayImpl("Hello, korea"));
        Display d2 = new CountDisplay(new StringDisplayImpl("Hello, world"));
        CountDisplay d3 = new CountDisplay(new StringDisplayImpl("Hello, Universe."));
        d1.display();
        d2.display();
        d3.display();
        d3.multiDisplay(5);
    }
}


// 실행 결과

+------------+
:Hello, korea:
+------------+
+------------+
:Hello, world:
+------------+
+----------------+
:Hello, Universe.:
+----------------+
+----------------+
:Hello, Universe.:
:Hello, Universe.:
:Hello, Universe.:
:Hello, Universe.:
:Hello, Universe.:
+----------------+

```


bridge 패턴은 기능의 클래스 계층과 구현의 클래스 계층을 분리했기 때문에, 각각 클래스 계층을 독립적으로 확장 할 수 있다. 

예를 들어, 기능을 추가하고 싶으면 기능 클래스 계층에만 추가를 하면되고 , 구현 클래스 계층을 수정할 필요가 전혀 없다. 

또한 새로 추가한 기능은 모든 구현에서 사용할 수 있다. 

예) OS( Window판, Macintosh판, UNIX판) 


### 참고자료
* [디자인패턴 Bridge 패턴]( http://showmiso.tistory.com/121 )
* [Java 언어로 배우는 디자인 패턴 입문 , 영진닷컴]
