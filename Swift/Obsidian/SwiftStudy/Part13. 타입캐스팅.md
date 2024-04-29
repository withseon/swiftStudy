## is 연산자
---
`인스턴스 타입 검사`

- 참이면 true, 거짓이면 false를 리턴한다.
- `상속 관계`에서 상위 클래스의 하위 클래스의 포함 관계와 연관있다.
- 이항 연산자이다.

```swift
class Person {
	var id = 0
	var name = "이름"
	var email = "abc@gmail.com"
}

class Student: Person { // Person 상속
	var studentId = 1
}

class Udergraduate: Student { // Student 상속
	var major = "전공"
}

let person1 = Person()
let student1 = Student()
let undergraduate1 = Undergraduate()
```

```swift
// person1은 Person 타입만 해당
person1 is Person // true
person1 is Student // false
person1 is Undergraduate // false

// student은 Person과 Student 타입에 해당
student1 is Person // true
student1 is Student // true
student1 is Undergraduate // false

// undergraduate1은 Person, Student, Undergraduate 모두 해당
undergraduate1 is Person // true
undergraduate1 is Student // true
undergraduate1 is Undergraduate // true
```

- Student 타입은 Person 타입을 포함하고 있다.
- Undergraduate는 Student 타입을 포함하고 있으며, Student 타입은 Person을 포함하고 있다.


### is의 활용

```swift
let person2 = Person()
let student2 = Student()
let undergraduate2 = Undergraduate()

let people = [person1, person2, student1, student2, undergraduate1, undergraduate2]

// Student 타입인 인스턴스의 개수를 세는 코드
var studentNumber = 0

for someOne in people {
    if someOne is Student {
        studentNumber += 1
    }
}

print(studentNumber) // 6
```

- Undergraduate 타입의 경우 Student 타입을 포함하고 있으므로, `someOne is Student`의 연산 결과가 true가 된다.



## as 연산자
---
`타입 변환`

- `as` : 하위 -> 상위 클래스 타입 (업캐스팅)
- `as?/as!` : 상위 -> 하위 클래스 타입 (다운캐스팅)
- String(Swift 타입) <----> NSString(Objective-C

```swift
let person: Person = Undergraduate() // ✨ 인스턴스의 메모리 관련 주의
person.id
person.name
person.studentId // ERROR
person.major // ERROR
```

- Undergraduate()로 인스턴스를 생성하였지만, Person 타입으로 담았기 때문에 studentId와 major 속성에 접근할 수 없다.
- `속성이 존재하지 않아서 접근할 수 없는 것이 아니다.` Undergraduate()로 생성하였기 때문에 메모리 공간(heap)에 속성이 존재한다.

### as?

```swift
if let p1 = person as? Undergraduate {
	p1.id
	p1.name
	p1.studentId
	p1.major
}

let person2 = Person()

let p2 = person2 as? Undergraduate
print(p2) // nil
```

- `as?`를 사용하여 다운캐스팅을 할 때 성공하면 옵셔널 타입을, 실패하면 nil을 리턴한다.
- 옵셔널 언래핑이 필요하다.

### as!

```swift
let p3 = person as! Undergraduate
```

- `as!`를 사용하여 다운캐스팅을 할 때 성공하면 해당 타입을, 실패하면 런타임 오류가 발생한다.


### as의 활용 (Bridging)
- *Bridging: 서로 호환되는 형식을 캐스팅하여 쉽게 사용하는 것*

`String(Swift 타입)`과 `NSString(Objective-C 타입)`은 상호 호환이 가능하다.
따라서, 다운캐스팅 시에도 `as` 키워드를 사용한다.

```swift
let str = "Hello"
let otherStr = str as NSString
```



## 타입과 다형성


```swift
class Person {
	var id = "이름"
	var age = 0
	
	func walk() {
		print("사람이 걷는다.")
	}
}

class Student: Person {
	override func walk() {
		print("학생이 걷는다.")
	}
	func study() {
		print("학생이 공부한다.")
	}
}

class Undergraduate: Student {
	override func walk() {
		print("대학생이 걷는다.")
	}
	override func study() {
		print("대학생이 공부한다.")
	}
	func party() {
		print("대학생이 파티를 한다.")
	}
}
```

```swift
let person1 = Person()
person1.walk() // 사람이 걷는다.

let student1: Person() = Student()
student1.walk() // 학생이 걷는다.
// student1.study() // ERROR. Person 타입으로 선언되었기 때문에 접근 불가

let undergraduate1: Person() = Undergraduate()
undergraduate1.walk() // 대학생이 걷는다.
// undergraduate1.study() // ERROR. Person 타입으로 선언되었기 때문에 접근 불가
// undergraduate1.party() // ERROR. Person 타입으로 선언되었기 때문에 접근 불가
```

- `person1`, `student1`, `undergraduate1`은 모두 Person 타입으로 선언되어 있다.
- 하위 클래스의 인스턴스를 생성한 후, 상위 클래스 타입으로 담으면 인스턴스 메모리는 존재하지만 추가된 속성과 메서드에는 접근할 수 없다.
- ✨ `walk() 호출 시, 하위 클래스에서 재정의된 메서드가 실행된다.` (하위 클래스 생성자로 인스턴스를 생성했기 때문..! 업캐스팅 시 추가된 속성과 메서드에 대한 접근만 제한을 받는다 !!)


✨ 업캐스팅 시, 생성된 인스턴스의 메모리 구조(속성과 메서드에 따른 구조)와 스택에 선언된 변수(상수)가 가르키는 인스턴스의 메모리 구조를 생각해보자.


### ✨ 다형성
`하나의 객체(인스턴스)가 여러가지의 타입 형태로 표현`
(하나의 타입으로 여러 종류의 객체가 여러가지 형태로 해석)
- 상속했을 때, 재정의된 메서드가 실행되는 것 또한 다형성의 하나이다.
- 프로토콜과도 연관이 있다.


```swift
let people: Person = [Person(), Student(), Undergraduate()] // 업케스팅

for person in people {
	person.walk()
}

// 사람이 걷는다.
// 학생이 걷는다.
// 대학생이 걷는다.
```

- 업캐스팅된 형태의 메서드를 호출해도 `실제 메모리에 구현된 재정의된 메서드`가 호출된다.
- 하나의 타입`(Person)` 으로 인식되는 인스턴스가 각각의 실제 인스턴스 타입`(Student, Undergraduate)`에 따라 다른(재정의된) 메서드`(walk)`를 호출한다. -> 다형성




## Any
`어떤 타입의 인스턴스도 표현할 수 있는 타입 (옵셔널 타입 포함)`

- 저장된 타입의 메모리 구조를 알 수 없기 때문에, 항상 `타입 캐스팅`해서 사용해야 한다.

```swift
var some: Any = "Swift"
some.count // EROOR
(some as! String).count // 타입 캐스팅

some = 10
some = 3.2
print(some) // 3.2
```

```swift
// Any타입의 배열에는 각각 다른 타입을 담을 수 있다.
let array: [Any] = [5, "안녕", 3.5, Person(), Superman(), {(name: String) in return name}]

(array[1] as? String)?.count // 옵셔널 체이닝
```

### swift문과 타입캐스팅

```swift
for (index, item) in array.enumerated() {
	switch item {
	case is Int: // item is Int
		print("\(index): 정수입니다.")
	case let num as Double: // let num = item as? Double (성공시에만 담기기 때문에 ? 생략)
		print("\(index): 소수 \(num)입니다.")
	case is String:
		print("\(index): 문자열입니다.")
	case let person as Person:
		print("\(index): 사람입니다.")
		print("이름은 \(person.name)입니다.")
		print("나이는 \(person.age)입니다.")
	case is (String) -> String:
		print("\(index): 클로저입니다.")
	default:
		print("\(index): 그 외의 타입입니다.")
	}
}
```

- `is Int`: 타입이 Int 일 때 true
- `let num as Double`: Double로 타입 캐스팅이 가능하면, 바인딩



## AnyObject
`어떤 클래스의 인스턴스도 표현할 수 있는 타입`

- 저장된 타입의 메모리 구조를 알 수 없기 때문에, 항상 `타입 캐스팅`해서 사용해야 한다.

```swift
let objArray: AnyObject = [Person(), Superman(), NSString()]

(objArray[0] as! Person).name // 타입 캐스팅
```




### 옵셔널 값의 Any 변환

- 의도적으로 옵셔널을 사용하는 경우가 있는데, optional  타입을 그대로 사용하게 되면 xcode에서 경고창을 띄워준다.
- Any로 타입캐스팅(업캐스팅)하면 옵셔널 값을 그대로 사용한다는 의미가 되어 경고창이 사라진다.

```swift
let optionalNumber: Int? = 3
print(optionalNumber) // 경고. Optional(3)
print(optionalNumber as Any) // Optioinal(3)
```
