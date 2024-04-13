## 클래스와 구조체의 이해
---
### 객체지향  프로그래밍

`클래스(틀) -> 객체(실제 데이터)` ex) 붕어빵 틀 -> 슈크림 붕어빵

```
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

```
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
- 스택프레임(Stack Frame) 종료 시, 메모리에서 자동 제거

### 구조체
- 값형식(Value Type)
- 인스턴스 데이터를 모두 스택(Stack)에 저장
- 데이터를 복사할 때, 값이 전달되며 다른 메모리 공간이 생성됨
- ARC 시스템을 통해 메모리 관리 (메모리 릭 주의)

데이터 복사 예제

```
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

```
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

```
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

```
// 구조체
struct Animal {
	var name = "동물"
	var age = 0
}

let animal = Animal()

animal.name = "호랑이" // ERROR
```

- `let animal = Animal()` 선언했기 때문에, animal이 담고 있는 데이터 값은 변할 수 없다. 따라서 animal의 name을 변경하는 코드에서는 에러가 난다!


