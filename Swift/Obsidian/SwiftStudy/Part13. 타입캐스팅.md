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

