## 클래스와 구조체의 이해
---
### 객체지향  프로그래밍

`클래스(틀) -> 객체(실제 데이터)` ex) 붕어빵 틀 -> 슈크림 붕어빵

```swift
// 클래스(틀)
// 붕어빵 틀이라고 생각하기
class Dog {
	var name = "강아지"
	var weight = 0
	
	func sit() {
		print("\(self.name)가 앉았습니다.")
	}
}
```

```swift
// 객체(실제 데이터)
// Dog()로 붕어빵을 찍어냈다고 생각하기
var bori = Dog() // 객체를 생성하여 변수 bori에 저장

print(bori.name) // "강아지"
bori.name = "보리"
bori.weight = 5
print(bori.name) // "보리"

bori.sit() // "보리가 앉았습니다."

var choco = Dog() // 객체를 생성하여 변수 choco에 저장

print(choco.name) // "강아지"
choco.name = "초코"
choco.weight = 7

choco.sit() // "초코가 앉았습니다."
```

- Dog이라는 붕어빵 틀로 bori라는 이름의 붕어빵 하나와 choco라는 이름의 붕어빵 하나를 찍어낸 것이라고 생각하면 된다!
- 접근연산자(.)로 하위 변수나 메서드 (붕어빵 속재료라고 생각하자)에 접근할 수 있다.

> **용어 정리**
> 클래스, 구조체 내의 변수 -> `속성(property)`
> 클래스, 구조체 내의 함수 -> `메서드(method)`
> 클래스, 구조체로 메모리에 찍어낸 것 -> `인스턴스(instance)` (클래스에서는 '객체(object)'라고 부름)

## 클래스와 구조체
`가장 큰 차이는 '메모리 저장 방식'의 차이`

### 클래스
- 참조 형식(Reference Type)
- 인스턴스 데이터는 힙(Heap)에 저장되고, 해당 인스턴스를 가르키는 변수는 스택(Stack)에 저장
  메모리 주소값이 힙(Heap)을 가르킴
- 데이터를 복사할 때, 값을 전달하는 게 아닌 저장된 주소를 전달
- ARC 시스템을 통해 메모리 관리 (메모리 릭 주의)

### 구조체
- 값형식(Value Type)
- 인스턴스 데이터를 모두 스택(Stack)에 저장
- 데이터를 복사할 때, 값이 전달되며 다른 메모리 공간이 생성됨
- 스택프레임(Stack Frame) 종료 시, 메모리에서 자동 제거

데이터 복사 예제

```swift
// 클래스
// 클래스는 값 전달 X. 저장된 주소를 전달!!
class Person {
	var name = "사람"
}

var p = Person()
p.name = "혜리"
print(p.name) // "혜리"

var p2 = p
p2.name = "지원"
print(p2.name) // "지원"

print(p.name) // "지원"
```

- 클래스는 값을 전달해주는 게 아니라, 객체의 메모리 주소값을 전달해주기 때문에, 변수 p2는 p 객체의 메모리 주소를 참조하고 있는 것. (= p와 p2는 동일한 곳을 가르키고 있다.)
- 따라서, p2.name을 변경하면 p.name을 변경한 것과 같다.

```swift
// 구조체
// 구조체는 값 전달. 새로운 메모리 공간이 생성
struct Animal {
	var name = "동물"
}

var a = Animal()
a.name = "사자"
print(a.name) // "사자"

var a2 = a
a2.name = "호랑이"
print(a2.name) // "호랑이"

print(a.name) // "사자"
```

- 구조체는 값을 복사해서 전달하기 때문에, 새롭게 생성된 a2 인스턴스의 메모리 공간에 a의 값이 복사되어 저장된다.
- a2.name을 변경한 것은 a.name와 무관하다.

### 클래스와 구조체의 let과 var 키워드

```swift
// 클래스
class Person {
	var name = "사람"
	var age = 0
}

let person = Person()

person.name = "유진"
print(person.name) // "유진"
```

- `let person = Person()` 으로 선언했는데, 왜 name을 변경할 수 있을까?
- person이 담고 있는 건 메모리 주소기 때문에, 메모리 주소가 변할 수 없는 것이지 내부 메모리는 변경될 수 있다!

```swift
// 구조체
struct Animal {
	var name = "동물"
	var age = 0
}

let animal = Animal()

animal.name = "호랑이" // ERROR
```

- `let animal = Animal()` 선언했기 때문에, animal이 담고 있는 데이터 값은 변할 수 없다. 따라서 animal의 name을 변경하는 코드에서는 에러가 난다!


### 접문법의 정확한 의미
- = 명시적 멤버 표현식(Explicit Member Expression)
- = (점)을 사용한 문법

점문법을 사용하여 `내부 요소(= 인스턴스의 멤버)에 접근한다.`
(인스턴스의 멤버에는 속성과 메서드가 있다.)


### 관습적인 부분
- 클래스와 구조체 모두 속성 - 메서드 순으로 작성
- 내부에는 `메서드 실행문 불가. 메서드 선언만 가능`


## 초기화 메서드(Initializer)
---
사실 위에서 작성한 예제는 붕어빵을 틀에 맞춰서 만든 뒤, 속재료를 바꿔주는 느낌
초기화를 하면 붕어빵을 틀에 맞춰 만들 때 속재료까지 넣어버릴 수 있다.

- `init()`
- 모든 저장 속성(변수)을 초기화해야 한다.
- 초기화 메서드(생성자) 종료 시점에 모든 속성의 초기값이 저장되어야 한다. (초기화가 완료되지 않으면 컴파일 에러)
- 초기화의 목적은 `저장속성 초기화`
- 클래스, 구조체, (열거형)은 그냥 틀이다. 실제로 사용하기 위해서는 초기화 과정이 필요하다!
- `오버로딩`을 지원하기 때문에 다양한 파라미터 조합으로 생성자를 여러개 구현할 수 있다.

```swift
class Dog {
	var name: String
	var weight: Double
	
	// 초기화 함수는 func 키워드를 사용하지 않음
	init(name: String, weight: Double) {
		self.name = name
		self.weight = weight
	}
}
```

- `self`는 클래스/구조체에서 해당 인스턴스(자기 자신)를 의미한다.
- 위와 같이 초기화 함수의 파라미터와 인스턴스의 속성 이름이 같을 경우, 대입연산자 좌 우 모두 함수의 파라미터로 인식해버린다. 
  -> `self` 키워드를 사용하여 함수의 파라미터가 아닌, 인스턴스의 속성임을 알려줘야 한다.

```swift
var choco = Dog() // ERROR
var bori = Dog(name: "보리", weight: 15.0)

print(bori.name) // "보리"
print(bori.weight) // 15.0
```

- `var choco = Dog()`은 속성의 값을 초기화하지 않았기 때문에 메모리에 정상적으로 인스턴스가 생성되지 않아 에러가 발생한다.

### 속성이 옵셔널 타입인 경우

```swift
class Dog3 {
	var name: String?
	var weight: Int
	
	init(weight: Int) {
		self.weight = weight
	}
}

var dog7 = Dog3(weight: 10)
print(dog7.name) // nil
```

- Dog3의 속성 `name`은 옵셔널로 선언되어있는데, 옵셔널은 선언 시 값을 대입하지 않으면 nil로 초기화된다.
- 따라서, 옵셔널 타입의 속성은 init 메서드로 초기값을 설정해주지 않아도 된다!

```swift
class Dog4 {
	var name: String?
	var weight: Int
	
	init(name: String = "강아지", weight: Int) {
		self.name = name
		self.weight = weight
	}
}

var dog8 = Dog4(weight: 10)
print(dog8.name) // "강아지"
print(dog8.weight) // 10

var dog9 = Dog4(name: "보리", weight: 15)
print(dog9.name) // "보리"
print(dog9.weight) // 15
```

- `init(name: String = "강아지", weight: Int)`로 파라미터의 기본값을 설정해준다면,
  `var dog8 = Dog4(weight: 10)` 코드로 인스턴스를 생성할 때에 name은 설정된 기본값이 들어가게 할 수도 있고, `var dog9 = Dog4(name: "보리", weight: 15)`로 name의 값을 지정해줄 수도 있다.


### 식별 연산자
- 클래스에서는, 두 개의 참조가 `같은 인스턴스를 가르키는지`를 비교

```swift
var dog1 = Dog()
var dog2 = dog1

print(dog1 == dog2) // true
print(dog1 != dog2) // false
```


### 클래스와 구조체의 차이

> <ins>메모리 구조</ins>는,
> 구조체는 값형식(stack에 저장)으로 자동 제거
> 클래스는 참조형식(heap에 저장)으로 ARC로 관리
> 
> <ins>let으로 선언</ins>시,
> 구조체는 속성이 모두 상수로 선언
> 클래스는 가르키는 인스턴스가 고정. (저장 속성은 클래스 내 선언되었을 때 속성에 따름)
> 
> <ins>생성자</ins>는,
> 구조체에서는 자동으로 제공
> 클래스는 편의 생성자 존재
> 
> <ins>메서드와 속성</ins>에 대해,
> 구조체는 메서드 내에서 속성을 변경하려면 mutating 키워드 필요
> 클래스는 메서드 내에서 속성 변경 가능
> 
> <ins>소멸자</ins>는,
> 구조체에서는 없고
> 클래스에서는 있다.
> 
> <ins>상속</ins>은,
> 구조체는 불가능하고
> 클래스는 가능하다.


## 클래스와 구조체의 사용 이유
---

1. 사용하려는 모델의 설계
	- 관련 데이터를 한 곳에 모아 사용
2. 애플이 미리 설계해 놓은 클래스/구조체를 잘 사용하기 위함

### 언제 클래스/구조체를 사용해야 하는가
- 프로젝트의 사례 적합성에 따라 선택한다.

1. 메모리 관점

`변수/상수 -> 구조체 -> 클래스`

- 구조체는 stack에 저장되고, scope가 끝날 때 자동적으로 삭제되기 때문에 데이터적인 관점에서 클래스보다 가볍게 사용할 수 있다.
- 클래스가 구조체보다 느리기 때문에 필요한 경우에만 클래스를 사용하는 걸 지향하고 있다!

- 구조체 사용
	- 연관된 데이터들을 단순히 캡슐화할 때
	- 캡슐화한 데이터를 참조하는 것보다 복사해서 사용하는 게 효율적일 때
	- 저장 속성들이 값타입이며, 참조하는 것보다 복사하는 것이 합당할 때
- 클래스 사용
	- 상속이 필요할 때
	- 해당 모델을 serialize해서 전송하거나 파일로 저장할 필요가 있을 때



## 객체지향의 특징
---
### 추상화
- 실체들에서 공통적인 특징을 뽑아내서 하나의 분류로 만든 것 (= 모델링)
- ex) 도서관리 프로그램 -> 제목 / 저자 / 출판사 / 페이지 / 가격 등

### 캡슐화
- 연관 있는 속성과 메서드를 묶어서 활용한다는 개념
- 추상화는 디자인 레벨 관점에서의 개념, 캡슐화는 실제 코드 구현 레벨에서의 개념
- `은닉화`: 캡슐화를 하면, 접근제어자(private, public 등)을 사용해 객체 외부에서 내부 데이터의 접근 통제 가능

### 상속성
- 부모 클래스의 속성과 메서드를 자식 클래스에서 물려받는 개념
- 코드의 재사용성과 확장성이 높아짐

### 다형성
- 하나의 객체가 여러가지 타입 형태로 저장 가능
- 다양한 방식으로 동작 가능 (동적 바인딩/Method Dispatch)



