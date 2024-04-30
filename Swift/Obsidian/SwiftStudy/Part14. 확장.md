## 상속과 확장
---
### 상속
- 클래스만 가능하다.
- 상위 클래스(기존 타입)에서 속성을 추가하거나 메서드를 변형(추가)하여 하위 클래스(새로운 타입)을 생성한다.
- `수직적 확장`이다.

### 확장
- 클래스, 구조체, 열거형 모두 가능하다.
- 기존 타입에서 메서드를 추가하여 사용한다. (동일 타입)
- `수평적 확장`이다.

```swift
class Person {
	var name = "이름"
	var age = 0
	
	func walk() {
		print("사람이 걷는다.")
	}
}

// 상속
class Student: Person {
	var studentId = 1
	
	override func walk() {
		print("학생이 걷는다.")
	}
	
	func study() {
		print("학생이 공부한다.")
	}
}

// 확장
extension Student { // ✨ 스위프트에서는 확장에서 구현한 메서드에 대한 재정의 불가 (@objc 붙이면 가능)
	func play() {
		print("학생이 논다.")
	}
}

// 상속
class Undergraduate: Student {
	var major = "전공"

	override func walk() {
		print("대학생이 걷는다.")
	}
	override func study() {
		print("대학생이 공부한다.")
	}
	override func play() { } // ERROR. 확장에서 구현한 메서드는 재정의 불가
}
```

- 확장은 `메서드만` 추가가 가능하다.
- 확장으로 구현된 메서드는 상속을 통한 재정의가 불가능하다. 만약, 재정의를 하고 싶다면 구현부에 `@objc` 키워드를 붙여 사용한다.


### ✨ 확장에서 구현한 메서드는 왜 재정의가 불가능할까?

- <ins>확장으로 추가된 메서드는 기존의 메서드 테이블(배열로 되어 있음)에 추가되는 것이 아니다.</ins>
- 메서드 테이블 외에 공간에 메서드를 추가`(Direct Dispatch)`하기 때문에 상속은 되지만 재정의는 불가하다.
- Objective-C는 클래스의 메모리 구조가 Swift와 다르기 때문에(메서드 테이블에 배열 형태로 있는 것이 아님), 확장으로 메서드를 추가해도 재정의가 가능하다.


### 확장의 장점

- 원본 소스 코드에 액세스 권한이 없는 유형을 확장하여 사용할 수 있다. (소급 모델링)

```swift
struct Int { } // Int 타입은 구조체

extension Int {
	func squared: Int {
		return self * self
	}
}

5.squared // 25
```

- Apple이 제공하고 있는 기본 타입 `Int`에 사각형의 너비를 구하는 메서드를 추가하여 사용할 수 있다.


### ✨ 확장은 왜 메서드 형태만 정의할 수 있을까?

- `저장 속성은 고유한 메모리 공간을 갖는데`, 이는 컴파일 시점에 정해지게 된다. 따라서 기존 타입을 확장하여 새로운 저장 속성을 만들게 된다면 이미 정의된 메모리의 레이아웃(메모리에 저장된 구조)이 변경되어야 한다. 이런 과정에서 기존 코드와의 호환성 문제가 발생할 수 있다.
- `메서드는 고유한 메모리 공간을 갖지 않는다.` 따라서 할당된 메모리를 변경해야 하는 일이 발생하지 않는다.

### 확장에서 왜 지정 생성자와 소멸자는 정의할 수 없을까?

- 지정 생성자는 모든 저장속성에 값을 초기화해주어야 하는데, `확장에서는 private으로 선언된 속성에 대해 접근할 수 없다.` 또한, 확장에서 생성자를 추가하게 된다면 클래스 내의 생성자 동작 흐름에 방해가 될 수 있다.
- `소멸자는 하나만 존재할 수 있다.` 따라서, 유일성을 보장하기 위해 확장에서 소멸자는 정의할 수 없다.

### 정의할 수 있는 것들

1. (타입 / 인스턴스) 계산 속성
2. (타입 / 인스턴스) 메서드
3. 새로운 생성자 (편의 생성자에 한함)
4. 서브스크립트
5. 새로운 중첩 타입 정의 및 사용
6. 프로토콜 채택 및 프로토콜 관련 메서드


## 확장 가능 멤버
---
`메서드 형태만 가능하다.`

### (타입/인스턴스) 계산 속성
`속성 감시자는 추가가 불가능 (저장 속성을 감시하기 때문에) `

```swift
// 타입 계산 속성
extension Double {
	static var zero: Double { return 0.0 }
}

Double.zero // 0.0
```

```swift
// 인스턴스 계산 속성
extension Double {
	var km: Double { return self * 1_000.0 }
	var mm: Double { return self / 1_000.0 }
}

let oneInch = 25.4.mm
print("1인치는 \(onInch)미터") // 0.0254
let threeKiloMeter = 3.km
print("3킬로미터는 \(threeKiloMeter)미터") // 3000
```


### (타입/인스턴스) 메서드

```swift
// 타입 메서드
extension Int {
	static func printNumbersFrom1to5() {
		for i in 1...5 {
			print(i)
		}
	}
}

Int.printNumbersFrom1to5
// 1
// ..
// 5
```

```swift
// 인스턴스 메서드
extension String {
	func printHelloRepetitions(of times: Int) {
		for _ in 0..<times {
			print("Hello \(self)!")
		}
	}
}

"Steve".printHelloRepetitions(of: 3)
// Hello Steve!
// Hello Steve!
// Hello Steve!
```


*구조체 Mutating 키워드*
- 인스턴스의 속성 값을 변경하는 메서드를 구현하고자 할 때 `mutating` 키워드를 사용한다.
- 확장에서도 기존과 마찬가지로 mutating 키워드를 사용하여 속성의 값을 변경하는 메서드를 구현할 수 있다.

```swift
extension Int {
	mutating func squared() {
		self = self * self
	}
}

4.squared() // ERROR

let someInt = 3
someInt.squared() // ERROR

var newInt = 4
newInt.squared() // 16
```



**클래스와 구조체의 생성자 자동 구현**

*클래스*
- 저장 속성의 초기값이 존재하는 경우, 생성자를 구현하지 않아도 기본 생성자가 자동으로 생성
*구조체*
- 모든 저장 속성의 초기값이 없는 경우, 멤버와이즈 이니셜라이저만 자동으로 생성. 
- 모든 저장 속성의 초기값이 있는 경우, 멤버와이즈 이니셜라이즈와 함께 기본 생성자가 자동으로 생성
- 특정 저장 속성의 초기값이 없는 경우, 모든 저장 속성을 파라미터로 하는 멤버와이즈 이니셜라이즈와 해당 속성을 파라미터로 하는 멤버와이즈 이니셜라이즈가 자동으로 생성


### 새로운 생성자 (클래스의 경우 편의 생성자만 가능)
- `클래스의 경우, 편의 생성자만 가능하다.`
- 구조체의 경우, 예외 사항을 제외하고 지정 생성자를 호출하는 형태만 가능하다. (구조체는 편의 생성자 X)
- 구조체의 예외 사항: 
  모든 저장 속성에 기본값이 있고 생성자가 구현되어 있지 않으면 생성자를 구현할 수 있다. 


**1. 클래스에서 새로운 편의 생성자 확장**

```swift
// 클래스
// UIColor 기본 생성자
// init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

extension UIColor {
	convenience init(color: CGFloat) { // 편의 생성자
		self.init(red: color/255, green: color/255, blue: color/255, alpha: 1) // 본체의 지정 생성자 호출
	}
}

UIColor.init(color: 1)
```

- 편의 생성자 안에서 본체의 지정 생성자를 호출하고 있다.



**2. 구조체에서  새로운 생성자 확장**
`자유롭게 생성이 가능하다.`

```swift
// 구조체 예시 1) - 모든 저장 속성에 기본값을 주지 않고, 본체에 생성자를 구현하지 않았을 때
struct Point {
	var x: Double
	var y: Double
	// 멤버와이즈 이니셜라이즈 자동 생성
	// init(x: Double, y: Double) {}
}

extension Point {
	// 본체와 다른 생성자 구현
	init(num: Double) {
		self.x = num
		self.y = num
		// 본체의 생성자 호출도 가능
		// self.init(x: num, y: num)
	}
}
```

- 저장속성에 기본값을 주지 않았기 때문에 멤버와이즈 이니셜라이저`init(x: Dobule, y: Double)`이 자동으로 생성된다.
- 따라서, 확장했을 때 `init(x: Dobule, y: Double)`형태의 생성자를 추가할 수 없다.
- 확장으로 구현한 생성자의 내부에는 저장속성을 바로 접근할 수도 있고 본체의 생성자를 호출할 수 도 있다.


```swift
// 구조체 예시 2) - 모든 저장 속성에 기본값을 주고, 본체에 생성자를 구현하지 않았을 때
struct Point {
	var x = 0.0, y = 0.0
	// 구조체에서 생성자 구현 안 할 시 자동으로 생성
	// init() {}
	// init(x: Double, y: Double) {}
}

extension Point {
	// 본체와 다른 생성자
	init(num: Double) {
		self.x = num
		self.y = num
		// 본체의 생성자 호출도 가능
		// self.init(x: num, y: num)
	}
}
```

- 모든 저장 속성에 대해 기본값을 갖게 하며 생성자를 따로 구현하지 않으면 기본생성자`init()`과 멤버와이즈 이니셜라이저`init(x: Double, y: Double)`이 자동적으로 구현된다.
- 따라서, 확장했을 때 `init()`이나 `init(x: Double, y: Double)`형태의 생성자는 추가할 수 없다.


```swift
// 구조체 예시 3) - 모든 저장 속성에 기본값을 주지 않고, 본체에 생성자를 구현하였을 때
struct Point {
	var x: Double
	var y: Double
	
	init(x: Double) { // 생성자 임의 구현
	// 모든 속성에 대한 초기화 필요
		self.x = x
		self.y = 0
	}
}

extension Point {
	init() {
		self.x = 0
		self.y = 0
		// 본체의 생성자 호출도 가능
		// self.init(x: Double)
	}
}

Point()
Point(x: Double)
```

- 모든 저장 속성에 대해 기본값을 주지 않고 사용자 임의의 생성자를 작성할 때, 생성자 내에서 모든 속성에 대한 초기화가 이루어져야 한다.
-  구조체에서 `init(x: Double)` 생성자를 임의로 구현하면, 기본 생성자`init()`과 멤버와이즈 이니셜라이저`init(x: Double, y: Double)` 자동으로 구현되지 않는다.
- 따라서 확장하여 `init()` 형태의 생성자를 추가할 수 있다.
- 확장으로 구현한 생성자의 내부에는 저장속성을 바로 접근할 수도 있고 본체의 생성자를 호출할 수 도 있다.

- 

```swift
// 구조체 예시 4) - 모든 저장 속성에 기본값을 주고, 본체에 생성자를 구현하였을 때
struct Point {
	var x = 0.0, y = 0.0
	
	init(x: Double { // 생성자 임의 구현
		self.x = x
	}
}

extension Point {
	// 본체와 다른 생성자 (지정 생성자를 호출하는)
	init() {
		self.x = 0.0
		// 본체의 생성자 호출도 가능
		// self.init(x: 0.0)
	}
}

Point()
Point(x: Double)
```

- 구조체에서 `init(x: Double)` 생성자를 임의로 구현하면, 기본 생성자`init()`과 멤버와이즈 이니셜라이저`init(x: Double, y: Double)` 자동으로 구현되지 않는다.
- 따라서 확장하여 `init()` 형태의 생성자를 추가할 수 있다.
- 확장으로 구현한 생성자의 내부에는 저장속성을 바로 접근할 수도 있고 본체의 생성자를 호출할 수 도 있다.



**2-1. 구조체의 예외 사항**
`본체에 생성자를 임의로 구현하지 않음으로써 기본 생성자나 멤버와이즈 이니셜라이저가 자동적으로 구현된다면, 이와 동일한 형태의 생성자는 확장으로 추가할 수 없다.`

```swift
// 구조체 - 본체 저장속성에 기본값이 있고, 생성자를 구현하지 않았을 때
struct Point {
	var x = 0.0, y = 0.0
	// 생성자 구현 안 해서 자동으로 생성
	// init()
	// init(x: Double, y: Double)
}

extension Point {
	init(num: Double) { // 본체와 다른 생성자
		// 내부에서 본체의 지정 생성자를 호출하지 않고 새로 구현할 수 있다.
		// 재정 생성자나 멤버와이즈 생성자를 호출할 수도 있다.
		self.x = num
		self.y = num
	}
}
```

-  구조체에서 생성자를 따로 구현하지 않으면 기본생성자`init()`과 멤버와이즈 생성자`init(x: Double, y: Double)`이 자동적으로 구현된다.
- 모든 저장 속성에 기본값이 설정되어 있다.
- 따라서, 확장하여 새로운 생성자를 추가할 때에 생성자 내부에서 본체의 지정 생성자를 호출하지 않을 수 있고 생성자 내부 내용을 임의로 구현할 수 있다.


**예제**

```swift
struct Size {
	var width = 0.0, height = 0.0
	// 생성자 자동 구현 init(), init(width: Double, height: Double)
}

struct Rect {
	var origin = Point()
	var size = Size()
	// 생성자 자동 구현 init(), init(origin: Point, size: Size)
}

// 확장
extension Rect {
	// 본체의 생성자를 호출하는 새로운 생성자
	init(center: Point, size: Size) {
		let originX = center.x - (size.width / 2)
		let originY = center.y - (size.height / 2)
		// 본체의 멤버와이즈 이니셜라이즈 호출
		self.init(origin: Point(x: originX, y: originY), size: size)
		// (예외 상황) 본체의 생성자를 호출하지 않고 직접 구현 가능
		// self.origin = Point(x: originX, y: originY)
		// self.size = size
	}
}
```

- 구조체의 모든 속성이 기본값이 주어지고 생성자를 따로 구현하지 않아 기본 생성자와 멤버와이즈 생성자가 존재할 때 (예외 상황)
- 확장에서 구현한 생성자 내에서 `본체의 지정 생성자를 호출해도 되지만, 내부 로직을 직접 구현해도 된다.`



### 서브스크립트



### 새로운 중첩 타입 정의 및 사용, 프로토콜 채택 및 관련 메서드
