## 상속
---
`성격이 비슷한 타입을 새로 만들어 1. 데이터(저장 속성)을 추가하거나, 2. 기능(메서드)를 변형시켜서 사용`
✨ 저장 속성은 메모리 공간을 가지고 있다.

- 클래스에만 있는 개념
- 다중 상속은 불가능하다.

용어
- 기본(Base) 클래스: 다른 어떤 클래스도 상속하지 않은 클래스
- 상대적인 기준: 부모(Parent)/슈퍼(Super) - 자식(Child)/서브(Sub)

1. 데이터(저장 속성) 추가
```swift
class Person {
	var name: String
	var age: Int
}

class Student: Person { // Person 클래스 상속
	var school: String
}

class Undergraduate: Student { // Student 클래스 상속
	var major: String
}

var undergraduate1 = Undergraduate()
undergraduate1.name = "타코"
```


### final 키워드
- `final class` 로 선언하게 되면, 상속을 할 수 없다.
- `final var(let)`/ `final func`로 선언하게 되면, 해당 멤버의 재정의가 불가능하다.


### override 키워드
- 상위 클래스의 멤버를 재정의할 때 사용한다.
- 재정의하고자 하는 속성/메서드 앞에 `override`를 붙여서 선언한다.
- 저장 속성은 재정의할 수 없다.


> UIKit은 클래스를 고도화하여 만들어두었다. 상속을 통해 프레임워크를 만들었기 때문에
> 상위 클래스에서 가지고 있는 속성을 하위 클래스에서 쓸 수 있음을 이해하자.


---
### ✨ 속성과 메서드의 메모리 구조
- 저장 속성은 추가만 가능한 이유가 무엇일까 (예외 제외)
- 메서드는 추가 및 변형이 가능한 이유가 무엇일까 

---


## 재정의(Overriding)
---
`상속 받은 상위 클래스의 멤버를 변형하여 사용`
속성(저장 속성 제외)과 메서드를 재정의할 수 있다.

### 오버로딩과 오버라이딩의 차이

- `overloading(오버로딩)`
  함수에서, 함수 하나의 이름에 여러 함수를 대응
- `overriding(오버라이딩)`
  클래스의 상속에서, 상위 클래스의 속성/메서드를 재정의


### 재정의 규칙
- `저장 속성`은 재정의가 불가하지만, 계산 속성의 형태(읽기/쓰기)나 속성 감시자 추가는 가능하다.
- `계산 속성`은 get/set의 추가는 가능하지만, 축소는 불가능하다. (set이 있는 경우) 속성 감시자 추가가 가능하다. 
- `지정 생성자`는 재정의를 필수적으로 해야 한다. (자동 상속되는 경우도 있긴 하다.)
- `편의 생성자`는 재정의가 불가하다. (자동 상속되는 경우도 있긴 하다.)
- `메서드`는 자유롭게 재정의가 가능하다.
- `서브스크립트`는 재정의가 가능하다.

- `타입 저장 속성`은 재정의가 불가하다. 계산 속성도, 속성 감시자 추가도 불가하다.
- `타입 계산 속성`은 class 키워드가 붙은 경우에 재정의가 가능하다.
- 재정의한 타입 저장/계산 속성에는 속성 감시자 추가가 원칙적으로 불가하다.


```swift
class SomeSuperClass {
	// 저장 속성
	var aValue = 0
	// 메서드
	func doSomething() {
		print("Do something")
	}
}

class SomeSubClass: SomeSuperClass {
	// ERROR. 저장 속성은 재정의 불가
	// override var aValue = 3 
	
	// 저장 속성을 계산 속성(메서드 형태)로 재정의 가능
	override var aValue: Int {
		get {
			return 1
		}
		set {
			// 상위 속성이기 때문에 super 키워드 사용
			super.aValue = newValue
		}
	}
	
	// 메서드 재정의
	override func doSomething() {
		// 상위 클래스의 메서드 호출
		super.doSomething()
		print("Do something in subClass)
	}
}

var sub = SomeSubClass()
sub.doSomething()
// "Do something"
// "Do something in subClass"
```

### super 키워드
- 상위 클래스의 멤버를 가르킬 때 사용한다.


---
### ✨ 저장 속성을 메서드의 형태로 재정의할 수 있는 이유 + 메모리 구조

- 저장 속성은 재정의가 불가능하다고 했는데, 메서드의 형태(계산 속성, 속성 감시자)로 재정의 할 수 있는 이유는 무엇일까?
- 저장 속성을 계산 속성 형태로 재정의할 때 주의할 점은 무엇일까?

---

