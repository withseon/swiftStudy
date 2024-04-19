
## 저장 속성
---
`값이 저장되는 일반적인 속성(변수)`

- let, var로 선언 가능
- 속성 자체가 `고유한 메모리 공간`을 가지기 때문에, 초기화 전에 초기값을 가지고 있거나 반드시 초기화를 해서 값을 가지고 있게 해야 한다. (옵셔널 타입의 경우 nil 가능)

```swift
class Dog {
	var name: String // 저장 속성
	var age: Int = 0 // 저장 속성
	
	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
}
```


### 지연 저장 속성(Lazy stored Properties)
`저장 속성의 초기화를 지연`

- `lazy` 키워드를 사용한다.
- `var(변수)` 만 가능
- 생성자에서 초기화를 하지 않기 때문에, `선언 시 초기값`을 무조건 설정해야 한다.
- 인스턴스가 초기화되는 시점에 초기화(메모리 공간이 생기고 값이 저장됨)되는 게 아니라, 해당 저장 속성에 접근할 때 개별적으로 초기화가 된다.

```swift
struct Cat {
	var name: String
	lazy var weight: Double = 0.0 // 지연 저장 속성. 초기값을 무조건 설정해야 한다.
	
	init(name: String) {
		self.name = name
	}
}

var nabi = Cat(name: "나비")
nabi.weight // 접근 시 초기화(메모리 공간 생기고 값 저장)
```

 *지연 저장 속성을 사용하는 이유*
> 1. 메모리 공간을 많이 차지하는 이미지 등의 속성에 저장할 때 (메모리 낭비를 막기 위함)
> 2. 다른 속성들을 이용해야 할 때 (다른 저장 속성에 의존하기 때문에 초기화 시점이 더 늦어야 함)

```swift
class AView {
	var a: Int
	// 1. 메모리 공간을 많이 차지하는 속성
	lazy var view = UIImageView()
	// 2. 다른 속성을 이용해야 하는 속성(다른 저장 속성에 의존)
	lazy var b: Int = {
		return a * 10
	}()
	
	init(num: Int) {
		self.a = num
	}
}

var view1 = AView(num: 10)
// a값이 저장된 후, 2. 다른 속성을 이용해야 하는 속성의 값이 저장된다.
view1.b // 100
```



## 계산 속성
---
`속성은 속성인데, 실질적으로 메서드`
다른 저장 속성에 의존해 결과가 나오는 메서드의 경우, 계산 속성으로 사용할 수 있다.

- 관련이 있는 두 가지 메서드(값을 읽는 메서드, 값을 지정하는 메서드)를 하나로 사용할 수 있다.
 - 실제 메모리 공간을 가지지 않고, 해당 속성에 접근했을 때 다른 속성에 접근하여 계산한 뒤 그 계산 결과를 리턴하거나 세팅한다.

- `var(변수)` 만 가능
- 자료형(타입)을 명시해주어야 한다.
- `get(getter)`: 해당 속성의 값을 읽는다. 반드시 선언해야 한다.
- `set(setter)`: 해당 속성의 값을 세팅한다. 생략이 가능하다.


```swift
class Person {
	var birth: Int = 0
	var age: Int {
		get { // 필수. get만 구현할 때는 get{} 생략 가능
			return 2024 - birth
		}
		set(age) { // 선택. 타입 생략 가능
			self.birth = 2024 - age
		}
		// 파라미터 생략 가능(내부에서 newValue 사용해야 함)
		/*
		set {
			self.birth = 2024 - newVlaue
		}
		*/
	}
}

var p1 = Person()
p1.birth = 2000
p1.age // 24. get이 실행됨

p1.age = 26 // set이 실행됨
p1.birth // 1998
```


### ✨ 계산 속성의 메모리 동작
메서드의 메모리 구조를 생각하면서, 어디서 부르고 어디서 실행되는지 생각하기


## 타입 속성
---
`인스턴스에 속한 속성이 아닌, 타입 자체에 속한 
인스턴스가 동일하게 가져야 하는 보편적인 속성이나, 공유해야하는 성격을 가진 속성을 타입 속성으로 선언한다.


```swift
class Dog {
	static var species: String = "Dog"
	
	var name: String
	var age: Int
	
	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
}

let bori = Dog(name: "보리", age: 3)

print(bori.name) // "보리"
// bori.species // 인스턴스의 하위 속성으로 가지고 있지 않기 때문에 에러
print(Dog.species) // "Dog"
```

- `species`는 인스턴스의 속성이 아닌, Dog타입의 속성이기 때문에 `Dog.species`로 접근해야 한다.


### 저장 타입 속성

- `static` 키워드를 사용한다.
- 타입 속성은 생성자로 초기화되지 않기 때문에 선언과 동시에 초기화를 해주어야 한다.
- 지연 속성(lazy)의 성격을 갖는다.
- 여러 스레드에서 동시에 접근하는 경우에도 한 번만 초기화되도록 보장된다.
-  **상속 시 하위 클래스에서 재정의가 불가능하다. (class 키워드도 불가)**

```swift
class Circle {
	// 저장 타입 속성 (값이 항상 있어야 함)
	static let pi = 3.14
	static var count = 0
	
	var radius: Double // 반지름
	
	init(radius: Double) {
		self.radius = radius
		Circle.count += 1
	}
}

print(Circle.pi) // 3.14

var circle1 = Circle(radius: 2)
print(Circle.count) // 1

var circle2 = Circle(radius: 5)
print(Circle.count) // 2
```

- `count`는 Circle 클래스가 가진 타입 속성이며, 저장 속성이다. 따라서, 인스턴스 내에서 이를 접근할 때 `Circle.count`로 접근한다.
- 인스턴스를 생성하지 않아도 접근이 가능하다.
- Int.max, Int.min, Double.pi도 저장 타입 속성이다.


### 계산 타입 속성

- `static` 혹은 `class` 키워드를 사용한다.
- `var`만 사용 가능하다.
- 상속 시 재정의가 가능하다.
- 타입에 메모리 공간이 할당되어 있지 않다.

```swift
class Circle1 {
	// 저장 타입 속성
	static let pi: Double = 3.14
	static var count: Int = 0
	
	// 계산 타입 속성 (set 구현 안 해서 read-only)
	static var multiPi: Double {
		return pi * 2 // Circle.pi
	}
}
```

- 계산 타입 속성도 생성할 수 있다.
- **상속 시 상위 클래스에서 class 키워드를 붙인 경우, 재정의가 가능하다.**

### Class 키워드
- 상속의 경우, 계산 타입에서 'static' 대신 `class` 키워드를 사용한다.
- 상속을 받아 재정의가 가능하게 한다.



## 속성 감시자(Property Observer)
---
`저장 속성 감시자`
저장 속성이 변하는 시점을 관찰하여 메서드가 호출된다. (속성 값이 현재 값과 같아도 설정될 때마다 호출됨)

- `willSet`: 속성 변경 직전
- `didSet`: 속성 변경 직후
- willSet과 didSet 중 하나만 구현하는데, 개발에는 주로 didSet이 사용된다.

- var(변수)로 선언된 저장 속성에 사용
- 지연 저장 속성에는 사용 불가능하다.
- 계산 속성 같은 경우에는 set이 있기 때문에 웬만하면 속성 감시자를 추가하지 않는다.
  다만, 상속으로 재정의가 이루어질 때 속성 감시자를 추가할 수 있다.

```swift
class Profile {
	// 일반 저장 속성
	var name: String = "이름"
	
	// 저장 속성 + 속성 감시자
	var statusmessage: String {
		willSet(message) { // 바뀔 값. 파라미터 생략 가능(내부에서 newValue 사용해야 함)
			print("메세지가 \(statusMessage) 에서 \(message)로 변경될 예정")
			print("상태메세지 업데이트 준비")
		}
		didSet(message) { // 바뀌기 전 값. 파라미터 생략 가능(내부에서 oldValue 사용해야 함)
			print("메세지가 \(message)에서 \(statusmessage)로 이미 변경되었습니다.")
			print("상태메세지 업데이트 완료")
		}
	}
	init(message: String) {
		self.statusMessage = message
	}
}

let profile1 = Profile(message: "기본 상태메세지") // 초기화 시, willSet/didSet 호출 X
profile1.statusMessage = "대나무 헬리콥터"

// 메세지가 기본 상태메세지 에서 대나무 헬리콥터로 변경될 예정
// 상태메세지 업데이트 준비
// 메세지가 기본 상태메세지에서 대나무 헬리콥터로 이미 변경되었습니다.
// 상태메세지 업데이트 완료
```



---
### ✨ 메서드의 메모리 동작
`함수는 명령어의 묶음이다. = 코드 영역에 있다.`
인스턴스의 메모리 구조, 메서드의 메모리 구조를 생각해보고 클래스와 구조체의 메서드 실행 시 어떤 방식으로 동작하는지 생각해보기


---


## 인스턴스 메서드
---

- 인스턴스에 메모리 공간이 할당되어 있지 않다.
- 메서드 접근 시, 인스턴스 이름으로 접근해야 한다.
- 값타입(구조체/열거형)에서는 인스턴스의 속성 값을 변경할 수 없다. -> `mutating`키워드를 붙여 수정

### 클래스의 메서드

```swift
class Dog {
	var name: String
	
	init(name: String) {
		self.name = name
	}
	
	func sit() {
		print("\(self.name)이 앉았습니다.")
	}
	
	func changeNameAndSit(name: String) {
		self.name = name // 인스턴스의 (저장) 속성 값 변경
		self.sit() // 메서드 내에서 메서드 호출 가능
	}
}
```

- changeNameAndSit에서 클래스 인스턴스의 저장 속성인 name의 값을 변경할 수 있다.

### 구조체의 메서드 (값타입의 예시)
- 값타입의 인스턴스 메서드 내에서 자신의 속성 값 수정이 불가능 하다. -> `mutating` 키워드 필요

```swift
struct Dog {
	var name: String
	
	func sit() {
		print("\(self.name)이 앉았습니다.")
	}
	
	mutating func changeNameAndSit(name: String) {
		self.name = name // mutating 키워드를 사용하여 인스턴스의 (저장) 속성 값 변경
		self.sit() // 메서드 내에서 메서드 호출 가능
	}
}
```

- changeNameAndSit에서 구조체 인스턴스의 저장 속성인 name의 값을 변경하기 위하여 메서드 선언 시 `mutating` 키워드를 사용하였다.


### 오버 로딩
`동일한 이름을 가지지만, 파라미터가 다른 함수(메서드)`

```swift
class Dog {
	var name: String = "dog"
	
	func sit() {
		print("\(self.name)이 앉았습니다.")
	}
	
	func sit(action: String) { // 오버 로딩
		print("\(self.name)이 \(action)하며 앉았습니다.")
	}
}
```



## 타입 메서드
---

- 타입에 메모리 공간이 할당되어 있지 않다.
- 인스턴스에 속한 속성이 아닌, 타입 자체에 속한 속성이기 때문에 Type.method() 형태로 접근해야 한다.
- `static` 대신 `class` 키워드를 사용하면 재정의가 가능하다.

```swift
class SomeClass {
	class func someTypeMethod() { // class 키워드를 사용하여 재정의를 할 수 있도록 함
		print("타입과 관련된 공통의 기능 구현")	
	}
}

PClass.PTypeMethod()
// "타입과 관련된 공통의 기능 구현"
```

```swift
// SomeClass를 상속받은 SomeThingClass
class SomeThingClass: SomeClass {
	override class func someTypeMethod() {
		print("타입과 관련돈 공통의 기능 구현 (업그레이드)")
	}
}

// "타입과 관련된 공통의 기능 구현 (업그레이드)"
```

- 자식 클래스에서 `override` 키워드를 사용함으로써, 재정의를 할 수 있다.



## 서브스크립트(Subscript)
---
`'인스턴스[숫자]'의 형태로 접근하는 메서드`

- `subscript`로 생성하며, 파라미터를 생략할 수 없다.
- 계산 속성과 같이 get, set으로 구현할 수 있고 set은 생략이 가능하다.
- 두 개 이상의 파라미터를 가질 수 있다.

```swift
class SomeData {
	var datas = ["A", "B", "C", "D", "E"]

	subscript(index: Int) -> String { // 함수(메서드)와 동일한 형태. 파라미터 생략 불가
		get {
			return datas[index]
		}
		set { // 파라미터를 생략하고 newValue를 사용해봄 (파라미터 사용도 가능)
			datas[index] = newValue
		}
	}
}

var data = SomeData()
data[0] // "A"
data[0] = "AA"
```


### 타입 서브스크립트

- `static subscript` 혹은 `class subscript`로 생성하며, 파라미터를 생략할 수 없다.
- `class` 키워드를 붙이면 재정의가 가능하다.

```swift 
enum Planet: Int { // 원시값
	case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune

	static subscript(num: Int) -> Self { // 타입 자신을 나타내기 때문에 Self 사용
		return Planet(rawValue: num)! // get만 구현했기 때문에 get{} 생략
	}
}

let mars = Planet[4]
print(mars) // mars
```


### ✨ 서브스크립트의 메모리 동작 과정 (저장 속성이 배열인 예시)
메서드의 메모리 구조를 생각하면서, 어디서 부르고 어디서 실행되는지 생각하기


## 접근 제어
`코드 내부의 세부 구현 내용을 숨기기 위해 사용 (은닉화)`

- 코드를 감출 수 있다.
- 영역을 분리시킴으로써 효율적으로 관리할 수 있다.
- 컴파일 시간이 줄어든다. (해당 변수가 어느 범위에서 쓰이는지 알기 때문)

```swift
class SomeClass {
	private var name: String = "이름" // 접근 제어자 사용
	
	func nameChange(name: String) {
		self.name = name
	}
}

var bori = SomeClass()
bori.name // ERROR. 외부에서 private 접근 불가
bori.nameChange("보리")
```


## 싱글톤(Singleton)
---
`앱 구현 시, 유일하게 한 개만 존재하는 객체가 필요한 경우`
한 번 생성된 이후, 앱이 종료될 때까지 유일한 객체로 메모리에 상주한다.

- `static let 이름 = 객체생성()`의 형태로 사용한다.
- 접근하는 순간 lazy하게 동작한다.
- 외부에서 새로운 객체를 생성하지 않도록 한다면, 생성자를 `private init()`로 선언한다.

```swift
class Singleton {
	// 타입 프로퍼티(전역변수)로 선언
	static let shared = Singleton() // 자신의 객체를 생성하여 전역변수로 할당
	var userInfoId = 12345
	
	private init() {}
}

Singleton.shared // 접근하는 순간 lazy(지연)하게 동작하여 메모리(데이터 영역)에 올라감

let object1 = Singleton.shared
object.userInfoId = 123456

let object2 = Singleton.shared // object1과 object2는 같은 객체를 가르킴
object2.userInfoId // 123456

// 생성자를 private으로 선언하였기 때문에 아래 코드는 ERROR
/*
let object3 = Singleton() // 새로운 객체
object3.userInfoId // 12345
*/
```
