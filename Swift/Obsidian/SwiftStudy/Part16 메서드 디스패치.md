
메서드는 CPU에 대한 명령어 ("코드 영역에 있는 코드를 실행시켜라~")
메서드를 실행시키기 위해서는 코드영역의 메서드 주소를 알아야 한다.


> 컴파일 타임
# Direct Dispatch(Static Dispatch)
`테이블이 필요 없음`

- 컴파일 시점에 코드 자체에 메서드의 메모리 주소 삽입
- 값 타입(구조체, 열거형)

```swift
struct MyStruct {
	func method1() { print("Struct - Direct method1") }
	func method2() { print("Struct - Direct method2") }
}

let myStruct = MyStrcut()
myStruct.method1() // 컴파일 시점에 메모리 주소 삽입
myStruct.method2() // 컴파일 시점에 메모리 주소 삽입
```



> 런타임
## Table Dispatch(Dynamic Dispatch)
`테이블 사용`

- 함수의 포인터(메모리 주소)를 배열 형태로 보관 후 실행
- 클래스, 프로토콜

**Virtual Table**
`클래스의 모든 메서드에 대한 메모리 주소를 갖는 테이블`

```swift
class FirstClass {
	func method1() { print("Class - Table method1") }
	func method2() { print("Class - Table method2") }
}
/*
Virtual Table
---------------------------------------------------------
method1() { print("Class - Table method1") } 의 메모리 주소
method2() { print("Class - Table method2") } 의 메모리 주소
---------------------------------------------------------
*/

class SecondClass: FirstClass { // 상속
	override func method2() { print("Class - Table method2-2") }
	func method3() { print("Class - Table method3") }
}

/*
Virtual Table
---------------------------------------------------------
method1() { print("Class - Table method1") } 의 메모리 주소 // FirstClass의 method1()의 주소
method2() { print("Class - Table method2-2") } 의 메모리 주소 // 재정의
method3() { print("Class - Table method3") } 의 메모리 주소
---------------------------------------------------------
*/

let first = FirstClass()
first.method1() // 데이터 영역의 Virtual Table의 메모리 주소를 통해 코드 실행
first.method2() // 데이터 영역의 Virtual Table의 메모리 주소를 통해 코드 실행

let second = SecondClass()
second.method1() // 데이터 영역의 Virtual Table의 메모리 주소를 통해 코드 실행
second.method2() // 데이터 영역의 Virtual Table의 메모리 주소를 통해 코드 실행
second.method3() // 데이터 영역의 Virtual Table의 메모리 주소를 통해 코드 실행
```


**Witness Table**
`프로토콜의 요구 사항에 대한 구체적인 구현이 이루어진 메서드의 메모리 주소를 갖는 테이블`

```swift
protocol MyProtocol {
	func method1() // 요구사항
	func method2() // 요구사항
}

extension MyProtocol {
	func method1() { print("Protocol - Witness Table method1") } // 기본 구현
	func method2() { print("Protocol - Witness Table method2") } // 기본 구현
	
	// 확장으로 추가한 메서드 (요구사항 아님)
	func anotherMethod() {
		print("Protocol Extension - Direct anotherMethod")
	}
}

class FirstClass: MyProtocol { // MyProtocol 채택
	func method1() { print("Class - Virtual Table method1") } // 채택 구현
	func method2() { print("Class - Virtual Table method2") } // 채택 구현
	func anotherMethod() { print("Class - Virtual Table method3") }
}

/*
Virtual Table
---------------------------------------------------------
method1() { print("Class - Virtual Table method1") } 의 메모리 주소
method2() { print("Class - Virtual Table method2") } 의 메모리 주소
anotherMethod() { print("Class - Virtual Table method3") } 의 메모리 주소
---------------------------------------------------------
*/

/*
Witness Table
---------------------------------------------------------
method1() { print("Class - Virtual Table method1") } 의 메모리 주소 // 우선순위 반영 (채택 구현 > 기본 구현)
method2() { print("Class - Virtual Table method2") } 의 메모리 주소 // 우선순위 반영 (채택 구현 > 기본 구현)
---------------------------------------------------------
*/

let first: FirstClass = FirstClass()
first.method1() // Class - Virtual Table method1
first.method2() // Class - Virtual Table method2
first.anotherMethod() // Class - Virtual Table method3

let proto: MyProtocol = FisrtClass()
proto.method1() // Class - Virtual Table method1 (Witness Table)
proto.method2() // Class - Virtual Table method2 (Witness Table)
proto.anotherMethod() // Protocol Extension - Direct anotherMethod
```



## Message Dispatch

- objective - C 에서 주로 사용
- 자식 클래스에서 재정의 하지 않고 상속받은 메서드를 실행시키고자 하면, 자식 클래스의 인스턴스에 접근하여, 상위 클래스로 간 다음에 메서드를 실행하는 형태
- `@objc dynamic` 키워드로 구현할 수 있다.

```swift
// swift에서 Message Dispatch 구현
class ParentClass {
	@objc dynamic func method1() { print("Class - Message Dispatch1") }
	@objc dynamic func method2() { print("Class - Message Dispatch2") }
}

/*
Message Table
---------------------------------------------------------
method1() { print("Class - Message Dispatch1") } 의 메모리 주소
method2() { print("Class - Message Dispatch2") } 의 메모리 주소
---------------------------------------------------------
*/

class ChildClass {
	@objc dynamic override func method2() { print("Class - Message Dispatch2-2") }
	@objc dynamic func method3() { print("Class - Message Dispatch3") }
}

/*
Message Table
---------------------------------------------------------
superclass // 상위 클래스의 Message Table을 가르킴
method2() { print("Class - Message Dispatch2-2") } 의 메모리 주소 // 재정의
method3() { print("Class - Message Dispatch2") } 의 메모리 주소
---------------------------------------------------------
*/

let child = ChildClass()
child.method1()
child.method2()
child.method3()
```

