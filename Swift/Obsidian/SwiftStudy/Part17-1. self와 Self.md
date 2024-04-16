## self
---
`인스턴스`
- 인스턴스들이 암시적으로 생성하는 속성
- "hello", "bori", 7 등

### 사용 예시

1. 인스턴스 내부에서 인스턴스 속성을 명확하게 가르키기 위해 사용

```swift
Class Person {
	var name: String
	
	init(name: String) {
		self.name = name
	}
}
```

- 생성자(init)의 파라미터가 name으로 인스턴스의 속성 이름과 동일하다. 
  이러한 경우에 `self` 키워드를 사용하여 name이 인스턴스의 속성을 가르키는 것을 명확하게 알려주어야 한다.


2. 값타입(구조체/열거형)에서 인스턴스 자체의 값을 치환할 때 사용 (참조타입은 불가)

```swift
struct Calculator {
	var number: Int = 0
	
	mutating func plus(_ num: Int) {
		number += num
	}
	mutating func reset() {
		// 인스턴스 값을 새로 생성된 값으로 치환
		self = Calculator()
	}
}
```

- `self = Calculator()`는 Calculator의 새로운 인스턴스를 만들어 그 값을 인스턴스 자신에 대입함으로써, 해당 인스턴스의 속성 number는 0이 된다.
  따라서, `self`는 인스턴스 자신이라고 이해하면 된다.
- `참조 타입`에서는 불가능하다.


3. 타입속성/메서드에서 사용하면, 타입 자체를 가르킴

```swift
struct MyStruct {
	static let club = "iOS"
	
	static func doPrinting() {
		print("\(self.club)")
	}
}
```

- `doPrinting`은 MyStruct의 타입 메서드로, 타입 메서드 내부에서 `self` 키워드를 사용하게 되면 해당 타입의 속성/메서드에 접근할 수 있다.
- doPrinting() 선언문의 `static`을 제거하면 타입 메서드가 아닌 인스턴스 메서드가 되고, 이 경우에는  `self.club`이 인스턴스의 속성을 의미하는 것으로 여겨지게 된다.
  따라서, 인스턴스 메서드에서 타입 속성에 접근하려면, `MyStruct.club`으로 사용해야 한다.


4. 타입 인스턴스를 가르킬 때, 타입 자체의 뒤에 붙여서 사용 (외부에서 타입을 가르키는 경우)

```swift
class MyClass {
	static let name = "MyClass"
}

let a: MyClass.Type = MyClass.self

print(MyClass.name) // MyClass.self.name의 축약 표현임
```

- 외부에서 특정 타입 인스턴스를 가르킬 때, `self` 키워드를 사용한다.




## Self
---
`타입`
- 특정 타입 내부에서 해당 타입을 가르킴
- String, Int 등

### 사용 예시

1. 특정 타입 내부에서 타입을 선언하는 위치에 사용
2. 특정 타입 내부에서 타입 속성/타입 메서드를 지칭하는 위치에서 타입 대신 사용

```swift
extension Int {
	// 타입을 Int로 표시하는 대신 Self를 사용
	// static let zero: Int = 0
	static let zero: Self = 0
	
	// var zero: Int {
	var zero: Self {
		return 0
	}
	
	// static func toZero() -> Int {
	static func toZero() -> Self {
		// 특정 타입의 속성을 지칭
		// return Int.zero
		return Self.zero
	}
	
	func toZero() -> Self {
		return self.zero
	}
}
```

- `static let zero: Self = 0`은 Int로 선언하는 대신 Self로 선언함으로써, 해당 타입과 동일한 타입임을 타나낸다.
- 타입 메서드 toZero() 내 `return Self.zero`는 타입이 가지고 있는 속성을 접근할 때, Int(해당 타입) 대신 `Self` 키워드를 사용하였다.


3. 프로토콜에서 채택하려는 타입을 지칭 가능

```swift
extension BinaryInteger {
	func squared() -> Self { // 타입
		return self * self // 인스턴스
	}
}

// Int 타입과 UInt 타입은 BinaryInteger를 채택
let x: Int = 7
let y: UInt = 7

print(x.squared())
print(y.squared()) 
```

- 다음은 BinaryInteger에 squared() 메서드를 추가한 코드이다.
- squared()의 리턴 타입에 `Self` 키워드를 사용함으로써, BinaryInteger를 채택한 타입을 리턴하도록 하였다.

```swift
// 범용적으로 사용 가능함을 의미
protocol Some {
	func turnOn() -> Self
}

extension String: Some {
	func turnOn() -> Self { // 타입(String)
		return ""
	}
}
```

- Some이라는 프로토콜 내 메서드의 리턴 타입으로 `Self`를 사용함으로써, Some을 채택한 타입에 대한 리턴이 가능하도록 하였다.

- 두 예시 코드를 통하여 프로토콜 내에 `Self` 키워드를 사용함으로써, 특정 타입에 대한 코드를 추가하지 않고 범용적으로 사용이 가능함을 알 수 있다.