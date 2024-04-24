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

## 초기화
---
`인스턴스를 생성하는 것`
인스턴스를 사용 가능한 상태로 만들기 위해서는, 저장 속성에 값을 주어야 한다.

**초기화 방법**
1. 저장 속성을 선언할 때, 값을 준다.
2. 저장 속성을 옵셔널 타입으로 선언한다. (값을 저장 안 하면 nil이 들어감)
3. 생성자를 통해 값을 초기화한다.


## 생성자
`초기화 메서드`

- `init` 키워드 사용
- 저장 속성을 초기화하여 인스턴스를 사용 가능한 상태로 만든다.
- 오버로딩을 지원하기 때문에 각기 다른 파라미터를 가진 생성자를 여러 개 구현할 수 있다.


### 기본 생성자
`init()`
- 저장 속성의 기본값을 설정하면 '자동 구현'이 제공된다.
- 클래스와 구조체 모두 제공이 된다.

```swift
class Dog {
	var name: String = "이름"
	var age: Int = 0
}

var dog1 = Dog() // Dog.init()의 축약 표현
```

- 컴파일러가`init()`을 자동으로 구현해주었기 때문에 Dog()으로 인스턴스를 생성할 수 있다.



### 멤버와이즈 이니셜라이저(Memberwise Initializer) - 구조체

- 구조체는 기본 생성자 init() 외에, 모든 멤버에 대한 값을 초기화해줄 수 있는 <ins>멤버와이즈 이니셜라이저</ins>를 제공한다.

```swift
struct Color1 {
	var red: Double = 0.0
	var green: Double = 0.0
	var blue: Double
}

var color1 = Color1(red: Double, green: Double, blue: Double) // 자동완성으로 띄워줌
var color2 = Color1(blue: Double)
```

- `init(red:, green:, blue:)` 를 따로 생성하지 않았지만 사용할 수 있음을 알 수 있다.
- 위의 코드와 같이 red, green에 초기값을 설정하고 blue에는 설정하지 않은 경우, `init(blue: Double)` 또한 제공된다.
- 저장 속성에 초기값을 설정하지 않아도 멤버와이즈 이니셜라이저를 사용할 수 있다.
- 생성자(이니셜라이저)를 따로 구현하면, 멤버와이즈 이니셜라이저는 자동으로 제공되지 않는다.


## 지정 생성자와 편의 생성자
---

### 구조체의 지정 생성자

`지정 생성자`는 모든 속성을 초기화 해야 한다.
오버로딩을 지원하기 때문에 각기 다른 파라미터를 가진 지정 생성자를 여러 개 구현할 수 있다.

```swift
struct Color1 {
	let red, green, blue: Double
	
	init() { // 다른 생성자 호출 가능
		// red = 0.0
		// green = 0.0
		// blue = 0.0
		self.init(red: 0.0, green: 0.0, blue: 0.0)
	}
	
	init(red: Double, green: Double, blue: Double) {
		self.red = red
		self.green = green
		self.blue = blue
	}
}

```

- 구조체는 생성자 내에서 다른 생성자를 호출할 수 있다. -> 코드의 중복을 줄일 수 있다.


### 클래스의 지정 생성자와 편의 생성자

`지정 생성자`는 모든 속성을 초기화 해야 한다.
`편의 생성자`는 모든 속성을 초기화 할 필요가 없다. 내부에서 지정 생성자를 호출한다. (지정 생성자에 의존적)

모든 속성을 초기화하지 않는 코드가 있다면, 지정 생성자와 편의 생성자로 구현하는 것이 권장된다.
(편의 생성자로 구현하면 코드의 중복을 줄일 수 있고, 코드를 작성하며 실수할 확률이 줄기 때문이다.)

```swift
class Color2 {
	let red, green, blue: Double
	
	convenience init() { // 편의 생성자는 다른 생성자 호출 가능
		self.init(red: 0.0, green: 0.0, blue: 0.0)
	}
	
	init(red: Double, green: Double, blue: Double) { // 지정 생성자
		self.red = red
		self.green = green
		self.blue = blue
	}
}
```

- 클래스는 `지정 생성자` 내에서만 다른 생성자를 호출할 수 있다.
- `convenience` 키워드를 사용한다.
- 여러 지정 생성자를 사용했을 때, 상속 이후의 복잡도가 올라가므로 이를 보완하기 위하여 사용한다.

```swift
class A {
	let x, y: Int

	init(x: Int, y: Int) { // 지정 생성자
		self.x = x
		self.y = y
	}

	convenience init() { // 편의 생성자
		self.init(x: 0, y: 0) // 지정 생성자 호출
	}
}

class B: A { // A 클래스를 상속한 B 클래스
	let x: Int // 저장 속성 추가

	init(x: Int, y: Int, z: Int) { // 지정 생성자
		self.z = z // ✨ 필수
		// self.y = y // ERROR. 상위 클래스의 저장 속성이 초기화되지 않았기 때문에 접근 불가
		super.init(x: x, y: y) // ✨ 필수. 상위 클래스의 초기화 메서드
		//self.y = y // 정상적으로 실행
	}

	convenience init(z: Int) { // 편의 생성자
		// self.z = 7 // ERROR. 메모리에 찍어내지 않았기 때문에 접근 불가
		init(x: Int, y: Int, z: z)
		// self.z = 7 // 정상적으로 실행
	}

	convenience init() { // 편의 생성자
		self.init(z: 0) // 편의 생성자 내에서 편의 생성자 호출
	}
}
```

- B 클래스의 지정 생성자`init(x: Int, y: Int, z: Int)` 내에서 상위 클래스(A)의 지정 생성자를 호출하기 전까지 상위 클래스의 저장 속성(x, y)에 접근할 수 없다.
- 지정 생성자가 저장 속성을 초기화 한다. 따라서 `convenience init(z: Int)`는 편의 생성자기 때문에, 지정 생성자를 호출한 이후에 저장 속성에 접근할 수 있다.
- 편의 생성자의 경우 서브클래스에서 재정의(override)를 할 수 없다.


> 상속이 이루어졌을 때, 
> `편의 생성자는 자신의 단계의 지정(편의) 생성자를 호출 (Delegate across)`하여야 하고
> `지정 생성자는 상위 클래스의 지정 생성자를 호출 (Delegate up)`하여야 한다.
> 이로써 모든 저장 속성의 값이 초기화되어야 인스턴스를 사용(생성)할 수 있다.


---
### ✨ 상속 관계에서 생성자(지정/편의) 호출과 메모리 구조
- 상위 클래스와 하위 클래스의 인스턴스 저장 속성과 관련하여 생각해보자.
- 코드, 데이터, 힙, 스택 영역의 메모리 구조와 관련하여 생각해보자.


---

## 생성자의 상속과 재정의
`상속 시, 상위 클래스의 지정 생성자와 현재 단계의 저장 속성을 고려해서 생성자를 구현해야 한다.`

```swift
class A {
	var x: Int = 0
	// 생성자를 만들지 않았기 때문에 init()이 자동으로 생성
}
```

**1단계) 상위 클래스의 생성자에 대해**

`지정 생성자`의 경우
- 하위 클래스에서 지정 생성자로 구현 (재정의)
- 하위 클래스에서 편의 생성자로 구현 (재정의)
- 반드시 재정의를 하지 않아도 된다.

`편의 생성자`의 경우
- 상속이 안 되므로, 재정의를 하지 않아도 된다.

```swift
class B: A {
	var y: Int
	
	// 상위 클래스의 지정 생성자를 하위 클래스에서 지정 생성자로 구현 (재정의)
	override init() {
		self.y = 0 // 2단계. 모든 저장 속성 초기화
		super.init() // 2단계. 상위 클래스의 지정 생성자 호출 필요
	}
	
	// 상위 클래스의 지정 생성자를 하위 클래스에서 편의 생성자로 구현 (재정의)
	/*
	override convenience init() {
		self.init(y: 0) // 2단계. 현재 클래스의 지정 생성자 호출 필요
	}
	*/
	
	// 재정의 하지 않아도 됨
}
```


**2단계) 현재 단계의 저장 속성을 고려**

`지정 생성자 내에서`
- 모든 저장 속성을 초기화하여야 한다.
- 상위 클래스의 지정 생성자를 호출해야 한다.

`편의 생성자 내에서`
- 현재 클래스의 지정 생성자를 호출해야 한다.

```swift
extension B {
	// 상위 클래스의 지정 생성자를 재정의한 게 아닌, 지정 생성자를 새로 구현한 것
	init(y: Int) {
		self.y = y // 2단계. 모든 저장 속성 초기화
		super.init() // 2단계. 상위 클래스의 지정 생성자 호출 필요
		// 상위 클래스 A에 기본 생성자 init() 밖에 없기 때문에 super.init()은 생략할 수 있음
	}
}
```

`상위 클래스에 기본 생성자 init() 밖에 없다면, 상속 시 하위 클래스에서 super.init()이 암시적으로 호출되므로 명시하지 않아도 된다.`


## 생성자 상속 예외 사항
`예외적으로 지정/편의 생성자의 자동 상속이 이루어지는 경우가 있다.`

**`지정 생성자`의 자동 상속**
- 하위 클래스의 저장 속성이 없는 경우
- 하위 클래스의 저장 속성에 기본값이 부여된 경우

**`편의 생성자`의 자동 상속**
- 지정 생성자를 자동으로 상속하는 경우
- 상위 클래스의 지정 생성자가 모두 구현(재정의)된 경우

```swift
class Food {
	var name: String

	init(name: String) { // 지정 생성자
		self.name = name
	}

	convenience init() { // 편의 생성자
		self.init(name: "Unnamed") // 지정 생성자 호출
	}
}
```

```swift
class RecipeIngredient: Food {
	var quantity: Int // 기본값 설정 안 해줌 -> 지정 생성자 필요

	init(name: String, quantity: Int) { // 지정 생성자
		self.quantity = quantity // 모든 속성 초기화
		super.init(name: name)
	}

	override convenience init(name: String) { // 상위 지정 생성자를 편의 생성자로 재정의
		self.init(name: name, quantity: 1) // 지정 생성자 호출
	}

	/*
	convenience init() { } // 상위의 지정 생성자를 모두 재정의하였기 때문에, 자동 상속
	*/
}

let oneMysteryItem = RecipeIngredient() // 하위 클래스에서 구현하지 않아도 자동 상속되어있음
oneMysteryItem.name // "Unnamed"
oneMysteryItem.quantity // 1
```

```swift
class ShoppingListItem: RecipeIngredient {
	var purchased = false // 저장 속성에 기본값을 설정
	var description: String = { // 계산 속성 
		var output = "\(quantity) x \(name)"
		output += purchased ? "O" : "X"
		return output
	}

	// 하위 클래스의 저장 속성에 기본값을 부여하였기 때문에, 지정 생성자가 자동으로 상속이 된다.
	// 따라서, 편의 생성자 또한 자동 상속이 이루어진다.
	// init(name: String, quantity: Int) {} -> 지정
	// convenience init(name: String) {} -> 편의
	// convenience init() -> 편의
}

var breakfastList = [
	ShoppingListItem(),
	ShoppingListItem(name: "Bacon"),
	ShoppingListItem(name: "Egg", quantity: 5)
]

breakfastList[0].name // "Unnamed"
```


## 필수 생성자
---
`상속 시, 반드시 하위 클래스에서 반드시 구현해야하는 생성자`

- `required` 키워드를 사용한다.
- 하위 클래스에서는 `override` 키워드 대신 `required` 키워드를 사용한다.
- 애플의 프레임워크에 필수 생성자가 존재하는 경우가 많다.

> 하위 클래스에서 다른 지정 생성자를 구현하지 않는 경우, 필수 생성자가 자동 상속된다.
> (다른 지정 생성자를 구현하게 된다면, 필수 생성자를 무조건 재정의(구현)해야 한다는 의미!!)

```swift
class AClass {
	var x: Int
	required init(x: Int) {
		self.x = x
	}
}

// 다른 지정 생성자를 구현하지 않았을 때
class BClass: AClass {
	/* 다른 지정 생성자를 구현하지 않았기 때문에, 필수 생성자가 자동 상속된다.
	required init(x: Int) {
		super.init(x: x)
	}
	*/

// 다른 지정 생성자를 구현했을 때
class CClass: AClass {
	init() { // 지정 생성자
		super.init(x: 0) // 상위 클래스의 필수 생성자 호출
	}
	required init(x: Int) { // 상위 클래스의 필수 생성자를 재정의
		super.init(x: x) // 상위 클래스 필수 생성자 호출
	}
}
```


### 필수 생성자 사용 예시 (UIView)

```swift
class AView: UIView {
	/* 다른 지정 생성자를 구현하지 않았기 때문에, 필수 생성자가 자동으로 상속
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	*/
}

class BView: UIView {
	override init(frame: CGRect) { // 지정 생성자를 구현한 경우
		super.init(frame: frame)
	}

	// 필수 생성자를 재정의해야 한다.
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
```



## 실패 가능 생성자
---
`인스턴스 생성 시, 실패 가능성을 가진 생성자`
`인스턴스 생성 실패로 인한 앱 크래시를 방지하기 위해 예외 처리를 해준다.`

- `init?()`으로 표현한다.
- 인스턴스 생성 실패 시, nil을 리턴한다.
- 오버로딩으로 인한 구분이 안 되기 때문에, 동일한 파라미터를 가진 생성자는 유일해야 한다.

```swift
class Animal {
	let species: String

	init?(species: String) {
		if species.isEmpty {
			// 생성자 내에서 return을 사용하지 않지만, 실패 가능 생성자의 경우 사용
			return nil
		}
		self.species = species
	}
	
	/* 동일한 파라미터를 갖는 생성자는 만들 수 없다.
	init(species: String) {
		self.species = species
	}
	*/
}

let a = Animal(species: "Giraffe") // Animal? 타입
let b = Animal(species: "")
b // nil
```

### 열거형의 실패 가능 생성자 활용

**실패 가능 생성자 활용**

```swift
enum TemperatureUnit {
	case kelvin, celsius, fahrenheit
	
	init?(symbol: TemperatureUnit) {
		switch symbol {
		case "K":
			self = TemperatureUnit.kelvin
		case "C":
			self = TemperatureUnit.celsius
		case "F":
			self = TemperatureUnit.fahrenheit
		default:
			return nil
		}
	}
}

let c: TemperatureUnit = TemperatureUnit.celsius
let f: TemperatureUnit? = TemperatureUnit(symbol: "F") // 실패 가능 생성자로 인스턴스를 생성하였을 때, 옵셔널 타입
```

**원시값 활용**
`원시값이 있는 열거형은 자동으로 실패 가능 생성자 init(rawValue:)를 생성`

```swift
enum TemperatureUnit1: Character {
	case kelvin = "K"
	case celsius = "C"
	case fahrenheit = "F"
}

let f1: TemperatureUnit1? = TemperatureUnit1(rawValue: "F") // .fahrenheit
let u: TemperatureUnit1? = TemperatureUnit1(rawValue: "X") // nil
```


### 실패 가능 생성자의 호출 관계
`실패 불가능 생성자는 다른 실패 가능 생성자를 호출할 수 없다. (범위 관계에 유의)`

**동일 단계에서 (Delegate Across)**
- 실패 가능 생성자 (에서) ===> 실패 불가능 생성자 ----- 호출/위임  ⭕️
- 실패 불가능 생성자 (에서) ===> 실패 가능 생성자 ----- 호출/위임 ❌

**상속 관계에서 (Delegate Up)**
- (상위) 실패 불가능 생성자 <=== (하위) 실패 가능 생성자 (에서) ----- 호출/위임 ⭕️
- (상위) 실패 가능 생성자 <=== (하위) 실패 불가능 생성자 (에서) ----- 호출/위임 ❌

```swift
// 상위 클래스
class Prodct {
	let name: String
	init?(name: String) { // 실패 가능 생성자
		if name.isEmpty { return nil } // name의 값이 없으면 인스턴스 생성 실패 -> nil
		self.name = name
	}
}
```

```swift
// 하위 클래스
class CartItem: Product {
	let quantity: Int
	init?(name: String, quantity: Int) { // 실패 가능 생성자
		if quantity < 1 { return nil } // quantity의 값이 1보다 작으면 인스턴스 생성 실패 -> nil
		self.quantity = quantity
		super.init(name: name) // name이 빈문자열이면 실패 가능 위임
	}
}

if let oneUnnamed = CartItme(name: "", quantity: 1) {
	print("아이템: \(oneUnnamed.name), 수량: \(oneUnnamed.quantity)")
} else {
	print("이름 없는 상품 초기화 불가")
}
// 이름 없는 상품 초기화 불가
```



### 상속 관계에서의 재정의
`상위 클래스의 실패 불가능 생성자를 하위 클래스에서 실패 가능 생성자로 재정의할 수 없다. (범위 관계에 유의)`

- (상위) 실패 가능 생성자 ===> (하위) 실패 불가능 생성자 ----- 재정의 ⭕️  `강제 언래핑 활용 가능`
- (상위) 실패 불가능 생성자 ===> (하위) 실패 가능 생성자 ----- 재정의 ❌

```swift
class Document {
	var name: String?
	
	init() {} // 실패 불가능 생성자
	
	init?(name: name) { // 실패 가능 생성자
		if name.isEmpty { return nil }
		self.name
	}
}
```

```swift
class AutomaticallyNamedDocument: Document {
	override init() { // 실패 불가능 생성자 -> 실패 불가능 생성자 재정의
		super.init()
		self.name = "[Untitled]"
	}

	override init(name: name) { // 실패 가능 생성자 -> 실패 불가능 생성자 재정의
		super.init()
		if name.isEmpty {
			self.name = "[Untitled]"
		} else {
			self.name = name
		}
	}
}

let autoDoc = AutomaticallyNamedDocument(name: "")
autoDoc.name // [Untitled]
```

```swift
class UntitledDocument: Document {
	override init() { // 상위의 실패 가능 생성자를 하위의 실패 불가능 생성자로
		super.init(name: "[Untitled]")! // ✨ 강제 언래핑 구현 (논리 구조 상 nil이 나올 수 없음)
	}
}
```


## init!()
`init?()과 동일한 역할을 한다.`

- init? ===> init! ----- 위임, 재정의 ⭕️
- init! ===> init? ----- 위임, 재정의 ⭕️

- init ===> init! ----- 위임 가능 (실패할 수도 있어짐) ✨


## 소멸자(deinit)
---
`인스턴스가 메모리에서 해제되기 직전 정리가 필요한 내용을 구현하는 메서드`

- 클래스 내에 최대 1개의 소멸자를 가질 수 있다.
- 파라미터를 사용하지 않는다.
- `클래스`에만 존재한다.
- 메모리에서 인스턴스가 해제되기 직전에 deinit이 자동으로 호출된다. (ARC로 메모리 관리)
- 직접적으로 호출하는 문법이 없다.

```swift
class AClass {
	var x = 0
	var y = 0

	deinit { // 소멸자
		print("인스턴스 소멸 시점")
	}
}

var a: AClass? = AClass()
a = nil // 메모리에 있던 a 인스턴스가 제거
```

상속이 있는 경우
- 상위 클래스의 소멸자는 하위 클래스에 의해 상속된다.
- 상위 클래스의 소멸자는 하위 클래스의 소멸자 구현이 끝날 때 자동으로 호출된다.
- 하위 클래스에서 자체적인 소멸자를 제공하지 않아도, 상위 클래스의 소멸자가 항상 호출된다.


# 정리
|           |                                 구조체                                  |                         클래스                          |
| :-------: | :------------------------------------------------------------------: | :--------------------------------------------------: |
|  지정 생성자   | init() { }<br>(생성자 구현 안 하면 <br>기본 생성자 + 멤버와이즈 생성자)<br>init(파라미터) { } | init() { }<br>(생성자 구현 안 하면 기본 생성자)<br>init(파라미터) { } |
|  편의 생성자   |                                  x                                   |        convenience init(파라미터) { }<br>(상속과 관련)        |
|  필수 생성자   |                                  x                                   |         required init(파라미터) { }<br>(상속과 관련)          |
| 실패 가능 생성자 |                  init?(파라미터) { }<br>init!(파라미터) { }                  |          init?(파라미터) { }<br>init!(파라미터) { }          |
|    소멸자    |                                  x                                   |                      deinit { }                      |
