## 타입 속성
---
`인스턴스에 속한 속성이 아닌, 타입 자체에 속한 
인스턴스가 동일하게 가져야 하는 보편적인 속성이나, 공유해야하는 성격을 가진 속상을 타입 속성으로 선언한다.

- `static` 키워드를 사용한다.
- 타입 속성은 생성자로 초기화되지 않기 때문에 선언과 동시에 초기화를 해주어야 한다.
- 지연 속성(lazy)의 성격을 갖는다.
- 여러 스레드에서 동시에 접근하는 경우에도 한 번만 초기화되도록 보장된다.

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
- **상속 시 하위 클래스에서 재정의가 불가능하다. (class 키워드도 불가)**


### 계산 타입 속성

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
