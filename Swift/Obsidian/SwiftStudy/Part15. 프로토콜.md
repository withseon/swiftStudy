
### 클래스와 상속의 단점

1. 하나의 클래스만 상속이 가능하다. (다중 상속 불가)
2. 상위 클래스의 메모리 구조를 따라갈 수 밖에 없다. (필요하지 않은 속성/메서드도 상속)
3. 클래스(래퍼런스 타입)에서만 가능하다.


> **프로토콜은**
> 동작을 따로 분리하여, 상속하지 않고도 사용 가능하게 한다.
> 구조체에서도 기능을 동작하게 한다.


## 프로토콜
---
`규약, 협약`

- 프로토콜 내에서 구체적인 구현은 하지 않는다. 프로토콜을 채택한 곳에서 구현한다.

```swift
protocol CanFly {
	func fly() // 요구사항
}
```

- CanFly 프로토콜을 채택하면, 채택한 곳에서 `fly()`를 구현해야 한다.

```swift
class Bird {
	var isFemale = true
	func layEgg() {
		print("새가 알을 낳는다.")
	}
}

class Egle: Bird, CanFly { // Bird를 상속하고 CanFly를 채택
	func fly() { // CanFly 프로토콜 메서드 구현
		print("독수리가 하늘로 날아올라 간다.")
	}
	func soar() { // 상속 받아서 메서드 추가
		print("공중으로 활공한다.")
	}
}

class Penguin: Bird { // Bird 상속
	func swim() { // 상속 받아서 메서드 추가
		print("물 속을 헤엄칠 수 있다.")
	}
}

struct Airplane: CanFly { // CanFly 채택
	func fly() { // CanFly 프로토콜 메서드 구현
		print("")
	}
}

struct FlyingMuseum {
	func flyingDemo(flyingObject: CanFly) { // 프로토콜을 타입으로 사용
		flyingObect.fly()
	}
}
```

- 클래스의 상속과 프로토콜 채택이 동시에 이루어지면, 상위 클래스를 앞에 프로토콜을 뒤에 선언한다.
- 프로토콜을 채택한 곳에서 프로토콜에 선언된 요구사항을 구현해야 한다.


## 프로토콜 문법
---

**1. 정의**

```swift
protocol MyProtocol {
	func doSomething() -> Int
}
```

- `protocol` 키워드를 사용한다.
- 프로토콜명은 대문자로 시작한다.
- 내부에는 최소한의 요구사항(기능)을 작성하며, 구현없이 선언한다.

**2. 채택**

```swift
class FamilyClass { }

// 클래스
class MyClass: FamilyClass, MyProtocol {
	
}

// 구조체
struct MyStruct: MyProtocol {
	
}

// 열거형
enum MyEnum: MyProtocol {
	
}
```

- 클래스의 상속과 동일하게 `:`를 사용하여 명시한다.
- 클래스의 상속과 프로토콜의 채택이 동시에 일어나는 경우 `class 클래스명: 상위클래스명, 프로토콜명` 처럼 상위클래스-> 프로토콜명의 순으로 선언한다.

**3. 속성/메서드의 구체적인 구현

```swift
class MyClass: FamilyClass, MyProtocol {
	func doSomething() -> Int {
		return 7
	}
}
```

- 프로토콜을 채택한 클래스,구조체,열거형 내부에서 프로토콜의 요구사항에 대한 구체적인 구현이 이루어져야 한다.


### 프로토콜의 요구사항 - 속성

- `var`로만 선언이 가능하다.
- `get`, `set` 키워드를 통하여 읽기/쓰기에 대한 여부를 설정해야 한다. (get은 필수)
- 채택한 곳에서 구현할 때, 저장 속성과 계산 속성 모두 가능하다.
 
```swift
protocol RemoteMouse {
	var id: String { get } // get은 최소한의 요구사항일뿐
	var name: String { get set }
	static var type: String { get set }
}
```

- 프로토콜 내의 요구사항은 '최소한의 요구사항'이다.

`var id: String { get }`
- RemoteMouse를 채택한 곳에서 `id 속성`을 구현할 때, 읽기가 가능한 String 타입임을 충족하면 된다.
- 따라서, String 타입의 let/var 모두 선언할 수도 있고,  읽기 계산 속성이나 읽기 쓰기 계산 속성으로 선언할 수도 있다. (get은 있기 때문에)

`var name: String { get set }`
- RemoteMouse를 채택한 곳에서 `name 속성`을 구현할 때, 읽기 쓰기가 모두 가능한 String 타입임을 충족하면 된다.
- 따라서, String 타입의 var로 선언할 수 있고, 읽기 쓰기가 가능한 계산 속성으로 선언할 수 있다. (get, set 모두 충족해야 하기 때문에)

`static var type: String { get set }`
- RemoteMouse를 채택한 곳에서 `type 속성`을 구현할 때, String 타입의 타입 속성임을 충족하면 된다.
- 따라서, String 타입의 타입 저장 속성과 타입 계산 속성으로 선언할 수 있다. (타입 속성이며 get, set 모두 충족해야 하기 때문에)
- 타입 계산 속성으로 구현했을 경우, `class` 키워드를 붙여 재정의가 가능한 상태로 만들 수 있다.



### 프로토콜의 요구사항 - 메서드

- 메서드의 헤드부분(인풋/아웃풋)의 형태만 정의한다.
- `mutating` 키워드를 붙여서 요구사항을 정의하면, 클래스는 `func ~`의 형태로 구현이 가능하고 구조체(열거형)의 경우에는 `mutating func ~`의 형태로 구현함으로써 구조체 내의 저장 속성 값 변경이 가능하게 된다.
- 타입 메서드의 경우에는 구현부에서 `class` 키워드를 사용할 수 있다.

```swift
protocol Toggleable {
	mutating func toggle() // 구조체에서 채택했을 때, 저장 속성 변경이 가능하도록 정의
}

enum OnOffSwitch: Toggleable {
	case on, off

	mutating func toggle() { // mutating 키워드 사용
		switch self {
		case .off:
			self = .on
		case .on:
			self = .on
		}
	}
}

class BigSwitch: Toggleable {
	var isOn = false

	func toggle() { // mutating 키워드 필요 없음
		isOn = inOn ? false : true
	}
}
```

- OnOffSwitch는 열거형이기 때문에, Toggleable을 채택한 후, 저장 속성의 값을 변경을 가능하게 해주는 `mutating` 키워드를 사용하여 메서드를 구현하였다.
- BigSwitch는 클래스이기 때문에, 저장 속성의 값을 바꾸는 데에 대한 제한이 없다. 따라서, mutating 키워드 없이 `func toggle()`의 형태로 구현하였다.



### 프로토콜의 요구사항 - 생성자(메서드)

- 클래스는 상속의 경우가 존재하기 때문에, `required` 키워드를 사용함으로써 '필수로 구현해야 하는 생성자'로 구현해야 한다.
- 다만, 해당 클래스를 `final` 키워드와 함께 선언하였을 때, 이후에 상속이 불가능해짐으로 `required` 키워드를 붙일 필요가 없다.
- 편의 생성자로도 구현이 가능하다.
- 구조체나 열거형의 경우, 상속이 없기 때문에 그냥 구현하면 된다.

*예제 1*

```swift
protocol SomeProtocol {
	init(num: Int)
}
```

```swift
class SomeClass: SomeProtocol {
	required init(num: Int) {
		// 구현
	}
	// 편의 생성자도 사용 가능
	// required convenience init(num: Int) {
	//    self.init()
	// }
	// 대신 지정생성자가 있어야 함
	// init() {  }
	
}

class SomeSubClass: SomeClass {
	// 하위 클래스에서 생성자 구현 안 하면 생성자 자동 상속
	// required init(num: Int) {  }
}
```

- `required` 키워드를 사용한 필수 생성자로 구현해야 한다.
- 편의 생성자`(convenience)`로도 구현할 수 있다.

```swift
final SomeClass: someProtocol {
	init(nuum: Int) {  }
}
```

- `final` 키워드를 사용하여 선언하면, `required` 키워드를 붙이지 않아도 된다.


*예제 2*

- 동일한 생성자에 대해 상속, 프로토콜 채택이 모두 이루어졌을 때

```swift
protocol AProtocol {
	init()
}

class ASuperClass {
	init() {
		// 내용
	}
}

class ASubClass: ASuperClass, AProtocol {
	// 프로토콜 채택에 대한 'required' 여부 상속으로 인한 재정의 'override' 키워드 모두 필요
	required override init() {
		// 구현
	}
}
```

- 기본 생성자를 요구사항으로 갖는 프로토콜과 기본 생성자를 가진 클래스를 상속한 클래스가 있는 경우, `required` 키워드와 `override` 키워드를 함께 사용하여야 한다.


*예제 3*

- 프로토콜의 요구사항이 실패 가능 생성자일 때

```swift
protocol AProto {
	init?(num: Int)
}

// 구조체
struct AStruct: AProto {
	init(num: Int) {
		// 구현
	}
}

// 클래스
class AClass: AProto {
	required init!(num: Int) {
		// 구현
	}
}
```

- 프로토콜의 요구사항이 실패 가능 생성자 `init?`인 경우, 이를 채택한 곳에서 실패 가능 생성자 `init?/init!`나 실패 불가능 생성자 `init` 모두 구현할 수 있다.
- 그 반대로 프로토콜의 요구사항이 실패 불가능 생성자 `init`인 경우, 이를 채택한 곳에서 실패 가능 생성자 `init?/init!`으로 구현할 수 없다.


### 프로토콜의 요구사항 - 서브스크립트(메서드)

-  `get`, `set` 키워드를 통하여 읽기/쓰기에 대한 여부를 설정해야 한다. (get은 필수)

```swift
protocol DataList {
	subscript(idx: Int) -> Int { get } // 최소한 읽기 구현
}

struct DataStructure: DataList {
	subscript(idx: Int) -> Int {
		get { // 프로토콜의 최소 요구사항이 get이니까 필수
			// 구현
		}
		set { // 프로토콜의 최소 요구사항이 get이니까 선택
			// 구현
		}
	}
}
```



*관습적인 프로토콜 채택과 구현*
- 확장에서 프로토콜을 채택하여 사용하는 것이 코드를 보다 깔끔하게 정리할 수 있다.
- 확장에서 채택하여 정의한 것은 재정의가 불가능하다.

```swift
protocol Certificate {
	func doSomething()
}

class Person {
	
}

extension Person: Certificate {
	func doSomething() {
		// 구현
	}
}
```


## 일급 객체 프로토콜
---
`프로토콜은 타입으로 사용이 가능하다.`
- 프로토콜을 변수에 할당할 수 있다.
- 프로토콜을 함수의 파라미터로 전달할 수 있다.
- 함수에서 프로토콜을 반환할 수 있다.

```swift
protocol Remote {
	func turnOn()
	func turnOff()
}

struct SetTopBox: Remote {
	func turnOn() {
		// 구현
	}
	func turnOff() {
		// 구현
	}
	func doNetflix() { }
}

// 프로토콜 타입으로 변수 선언 가능
let sbox: Remote = SetTopBox()
sbox.turnOn()
sbox.turnOff()
// sbox.doNetflix() // ERROR. 접근 불가
(sbox as! SetTopBox).doNetflix() // 다운캐스팅으로 접근
```

- 프로토콜 타입으로 변수를 선언할 수 있다.
- 클래스의 업캐스팅과 동일하게, 프로토콜로 타입 선언 시 프로토콜의 멤버에 접근이 가능하고 이를 채택한 곳에서 추가한 멤버는 접근이 불가능하다.
- 접근하고 싶으면 다운캐스팅을 해야 한다.


### 프로토콜 준수성 검사
`is`
- 해당 프로토콜을 채택하고 있는지 확인한다. (반대도 가능)
`as(as?/as!)`
- 타입 캐스팅. 업캐스팅은 항상 성공하지만, 다운 캐스팅은 실패 가능성을 가지고 있기 때문에 ?나 !를 붙여서 사용한다.



## 프로토콜 상속

- 프로토콜 간의 상속이 가능하며, 다중 상속이 가능하다.

```swift
protocol Remote {
	func turnOn()
	func turnOff()
}

protocol AirConRemote {
	func Up()
	func Down()
}

protocol SuperRemoteProtocol: Remote, AirConRemote {
	func doSomething()
}

// 채택
class HomePot: SuperRemoteProtocol {
	// 위의 다섯가지 요구사항에 대해 구현해야 함
}
```


### 클래스 전용 프로토콜
- `AnyObject`를 상속하여 프로토콜을 정의하면, 해당 프로토콜은 클래스에서만 채택할 수 있다.


### 프로토콜의 합성
`프로토콜명 & 프로토콜명`
- 해당 프로토콜을 모두 채택하고 있는 타입

```swift
let some: AProtocol & BProtocol = 두 프로토콜을 모두 채택한 타입의 인스턴스
```


## 선택적 요구 사항
---

- `@objc` 어트리뷰트를 사용하여 프로토콜을 선언한다.
- 선택적 요구 사항(멤버)는 `@objc optional` 키워드를 붙여서 선언한다.
- ✨ objc에서는 해당 형태(선택적 요구 사항 존재)가 클래스 전용 프로토콜이었기 때문에, 이 또한 클래스 전용 프로토콜이다.

```swift
@objc protocol Remote {
	@objct optional var isOn: Bool { get s et} // 선택적 요구 사항
	func turnOn() // 필수 요구 사항
}
```


> *@ Attribute 키워드*
> 1. 선언에 대한 추가 정보 제공
> 2. 타입에 대한 추가 정보 제공


*@objc*
- 스위프트로 작성한 코드를 Objective-C에서도 사용할 수 있게 해주는 어트리뷰트


