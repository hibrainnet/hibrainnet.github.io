---
layout: post
author: gh.park
title: "Chain of Responsibility pattern"
date: 2017-12-26 15:00:11 +0900
tags: [연구노트, 인턴십, javapattern]
category: [디자인패턴]
publication: 'gahye-blog'
license: 'public-domain'
permalink: /Chain-of-Responsibility
thumbnail: http://image.fileslink.com/491415f66486ded/image2017-12-26_14-31-10.png
---

### 연구내용

#### Chain of Responsibility (책임연쇄패턴)-책임떠넘기기
예를 들어, 어떤 요구가 발생했을 때, 그 요구를 처리할 객체를 바로 결정할수 없는 경우에는 다수의 객체를 사슬처럼 연결해 두고 객체의 사슬을 차례로 돌아다니면서 목적에 맞는 객체를 결정해야 한다.

즉, 어떤 객체에게 요구가 들어온다 → 그 객체가 그것을 처리할수 있으면 처리하고 처리할수 없으면 '다음 객체'에게 넘긴다 .

요청을 처리할 수 있는 기회를 하나 이상의 객체에게 부여함으로써, 요청하는 객체와 처리하는 객체 사이의 결합도를 낮춘 패턴이다.

요청 객체들과 처리 객체들로 이루어져 있으며, 각 처리 객체들은 명령 객체들의 타입을 정의해두며, 처리가 안된 남은 처리들을 다음 처리 객체에게 전달한다.

요청을 해결할 객체를 만날 때까지 사슬을 따라서 요청을 전달한다.

연결리스트와 비슷한 구조이다.

<br>

예) trouble을 해결하는 프로그램이다.

![1](http://image.fileslink.com/491415f66486ded/image2017-12-26_14-31-10.png)
![2](http://image.fileslink.com/491415f686c5fec/image2017-12-26_14-47-35.png)


|이름   |해설   |
|---|---|
| Trouble  |  발생한 트러블을 나타내는 클래스, 트러블의 번호를 갖는다.  |
|Support   |트러블을 해결하는 추상 클래스|
|NoSupport  |트러블을 해결하는 구상클래스(항상 처리하지 않음)|
|LimitSupport  |트러블을 해결하는 구상 클래스(지정한 번호 미만의 트러블을 해결)|
|OddSupport  |트러블을 해결하는 구상 클래스(홀수 번호의 트러블을 해결)|
|SpecialSupport |트러블을 해결하는 구상 클래스(지정 번호의 트러블을 해결)|
|Main  |Support들의 연쇄를 만들어 트러블을 일으키는 동작 테스트용 클래스|

<br>

##### Trouble 클래스
발생한 트러블을 표현하는 클래스, number은 트러블 번호, getNumber 메소드로 트러블 번호를 얻는다.


```java

public class Trouble {

    private int number;

    /**
     * 트러블 생성
     */

    public Trouble(int number) {
        this.number = number;
    }

    /**
     * 트러블의 번호를 얻는다.
     */

    public int getNumber() {
        return number;
    }

    /**
     * 트러블의 문자열 표현
     */

    public String toString() {
        return "[Trouble" + number + "]";
    }


}

```

##### Support 클래스
트러블을 해결할 연쇄를 만들기 위한 추상클래스, next필드는 떠넘기기를 할 곳을 가르킴, setNext 메소드는 떠넘기기 할 곳을 설정한다.

resolve메소드는 하위 클래스에서 구현할 것을 가상으로 생각하여 정한 추상 메소드이다.

반환값이 true 일때에 요구가 처리된것이고, false일때 요구가 아직 처리되지 않고 다음으로 넘겨질 것을 나타낸다.

Support 메소드는 resolve 메소드를 호출해서 반환값이 false면 다음사람에게 넘기고, 다음 사람이 없으면 아무도 처리할수 없다고 표시한다.


```java

public abstract class Support {

    /**
     * Support 클래스의 생성자
     *
     * @param     name  트러블 해결자의 이름
     * @param     next  떠넘기는 곳
     */

    private String name;
    private Support next;

    /**
     * 트러블 해결자의 생성
     */

    public Support(String name) {
        this.name = name;
    }

    /**
     * 떠넘길 곳을 설정
     */

    public Support setNext(Support next) {
        this.next = next;
        return next;
    }

    /**
     * 트러블 해결 순서
     */

    public final void support(Trouble trouble) {
        if(resolve(trouble)) {
            done(trouble);
        } else if(next != null) {
            next.support(trouble);
        } else {
            fail(trouble);
        }
    }

    /**
     * 문자열 표현
     */

    public String toString() {
        return "[" + name + "]";
    }

    /**
     * 해결용 메소드
     */

    protected abstract boolean resolve(Trouble trouble);

    /**
     * 해결
     */

    protected void done(Trouble trouble) {
        System.out.println(trouble + "is resolved by" + this + ".");
    }

    /**
     * 미해결
     */

    protected void fail(Trouble trouble) {
        System.out.println(trouble + "cannot be resolved.");
    }


}

```

##### NoSupport 클래스

Support 클래스의 하위 클래스로, resolve 메소드는 항상 false를 반환한다.

```java

public class NoSupport extends Support {

    /**
     * 트러블 해결자의 생성
     *
     */

    public NoSupport(String name) {
        super(name);
    }

    /**
     * 해결용 메소드, 항상 false를 반환함
     */

    @Override
    protected boolean resolve(Trouble trouble) {
        return false;
    }
}

```

##### LimitSupport 클래스
Limit로 지정한 번호 미만의 트러블을 해결하는 클래스

```java

public class LimitSupport extends Support {

    /**
     * 트러블 해결자의 생성
     *
     * @param limit  이 번호 미만일 경우 해결
     */

    private int limit;

    public LimitSupport(String name, int limit) {
        super(name);
        this.limit = limit;
    }

    /**
     * 해결용 메소드
     */

    @Override
    protected boolean resolve(Trouble trouble) {
        if (trouble.getNumber() < limit) {
            return true;
        } else {
            return false;
        }
    }
}

```

##### OddSupport 클래스
홀수 번호의 트러블을 처리하는 클래스 

```java

public class OddSupport extends Support {

    /**
     * 트러블 해결자의 생성
     *
     */

    public OddSupport(String name) {
        super(name);
    }

    /**
     * 해결용 메소드
     */

    @Override
    protected boolean resolve(Trouble trouble) {
        if (trouble.getNumber() % 2 == 1) {
            return true;
        } else {
            return false;
        }
    }
}

```


##### SpecialSupport 클래스
지정한 번호의 트러블에 한해서 처리를 하는 클래스


```java

public class SpecialSupport extends Support {

    /**
     * 트러블 해결자의 생성
     *
     * @param number  이 번호만 해결할 수 있음
     */

    private int number;

    public SpecialSupport(String name, int number) {
        super(name);
        this.number = number;
    }

    /**
     * 해결용 메소드
     */

    @Override
    protected boolean resolve(Trouble trouble) {
        if (trouble.getNumber() == number) {
            return true;
        } else {
            return false;
        }
    }
}

```

##### Main 클래스
여섯명의 트러블 해결자를 생성 한 후, 트러블을 1개씩 생성하여 alice에게 넘겨주고 누가 트러블을 해결할지 표시한다.


```java


public class HBNMain {

    /**
     * 여섯명의 트러블 해결자 및 연쇄 생성, 트러블 발생
     * @param     alice  NoSupport 클래스의 인스턴스로 구현하는 변수
     * @param     bob  LimitSupport 클래스의 인스턴스로 구현하는 변수
     * @param     charlie  SpecialSupport 클래스의 인스턴스로 구현하는 변수
     * @param     diana  LimitSupport 클래스의 인스턴스로 구현하는 변수
     * @param     elmo  OddSupport 클래스의 인스턴스로 구현하는 변수
     * @param     fred  LimitSupport 클래스의 인스턴스로 구현하는 변수
     */

    public static void main(String[] args) {

        Support alice = new NoSupport("Alice");
        Support bob = new LimitSupport("Bob", 100 );
        Support charlie = new SpecialSupport("Charlie", 429);
        Support diana = new LimitSupport("Diana", 200);
        Support elmo = new OddSupport("Elmo");
        Support fred = new LimitSupport("Fred", 300);

        /**
         * 연쇄의 형성
         */

        alice.setNext(bob).setNext(charlie).setNext(diana).setNext(elmo).setNext(fred);

        /**
         * 0부터 500까지 33씩 증가시키는 다양한 트러블 발생시켜서, Alice에서 전달
         */

        for (int i = 0; i < 500; i += 33 ) {
            alice.support(new Trouble(i));
        }
    }
}


// 실행 결과

[Trouble0]is resolved by[Bob].
[Trouble33]is resolved by[Bob].
[Trouble66]is resolved by[Bob].
[Trouble99]is resolved by[Bob].
[Trouble132]is resolved by[Diana].
[Trouble165]is resolved by[Diana].
[Trouble198]is resolved by[Diana].
[Trouble231]is resolved by[Elmo].
[Trouble264]is resolved by[Fred].
[Trouble297]is resolved by[Elmo].
[Trouble330]cannot be resolved.
[Trouble363]is resolved by[Elmo].
[Trouble396]cannot be resolved.
[Trouble429]is resolved by[Charlie].
[Trouble462]cannot be resolved.
[Trouble495]is resolved by[Elmo].

: 처음에는 Bob이 트러블을 해결, Bob이 해결할 수 없을때, Diana가 등장
실행 결과에는 Alice가 모든 트러블을 떠넘기기 때문에 실행결과에 전혀 등장하지 않음을 알 수 있다.


```


-Trouble363번 처리할 때의 시퀀스 다이어그램
![3](http://image.fileslink.com/491415f76c3634b3/image2017-12-26_15-11-47.png
)



1.8 Chain of Responsibility 패턴에 등장하는 역할



Handler(처리자)의 역할

요구를 처리하는 인터페이스를 정하는 역할을 수행
다음사람을 보관해 두었다가, 스스로 처리할 수 없는 요구가 발생하면 다음사람에게 넘김
예) Support 클래스


ConcreteHandler(구체적인 처리자)의 역할

요구를 처리하는 구체적인 역할
예) NoSupport, LimitSupport, OddSupport, SpecialSupport 클래스


Client(요구자)의 역할

최초의 ConcreteHandler역할에게 요구를 하는 역할
예) Main 클래스




1.9 Chain of Responsibility 패턴의 장점



요구를 하는 사람과 요구를 처리하는 사람을 느슨하게 연결한다. 이 패턴을 사용하지 않으면 ' 이 요구는 이 사람이 처리해야한다.' 라는 지식을 누군가가 가지고 있어야 한다.

만약 이 지식이 요구하는 사람에게 맡기면 처리자들의 역할 분담까지 상세히 알아야 하기 때문에, 독립성이 손상된다.



동적으로 연쇄의 형태를 바꿀수 있다. 위임에 따라 떠넘기기가 실행되면 상황의 변화에 따라서 ConcreteHandler역할을 다시 조립할 수 있다.


### 참고자료
* [책임 연쇄 패턴(chain of Responsibility)]( http://copynull.tistory.com/143)
* [책임 연쇄 패턴(chain-of-Responsibility pattern]( http://objectbuilder.tistory.com/84)
* [Java 언어로 배우는 디자인 패턴 입문 , 영진닷컴]
