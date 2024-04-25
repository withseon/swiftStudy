## 에러 처리
---
`에러 처리를 통해 런타임 오류를 방지할 수 있다.`

*컴파일 오류 = 스위프트 문법 오류
런타임 오류 = 앱이 실행되는 동안 발생 (앱 크래시)*


### 1단계, 에러 정의하기
- 어떤 에러가 발생할지 경우를 미리 정의한다.

```swift
enum HeightError: Error { // Error 프로토콜 채택
	case maxHeight
	case minHeight
}
```


### 2단계, 에러가 발생할 수 있는 함수에 대한 정의
- `throw` 키워드를 사용하여 에러를 던지는 함수를 구현한다.
- `(input 타입) throws -> (output 타입)` 의 형태를 갖는다.

```swift
func checkingHeight(height: Int) throws -> Bool { // 에러를 던질 수 있는 함수
	if height > 190 {
		throw HeightError.maxHeight // 에러 던짐
	} else if height < 130 {
		throw HeightError.minHeight // 에러 던짐
	} else {
		if height >= 160 {
			return true
		} else {
			return false
		}
	}
}
```


### 3단계, 에러가 발생할 수 있는 함수의 처리 (함수 호출)
- `try`와 `do-catch`문으로 처리해주어야 한다.

```swift
do { // 정상적인 경우의 처리 상황
	let result = try checkingHeight(height: 200)
	print("결과값 \(result)")
} catch { // 에러를 던졌을 때 처리 상황
	print("에러 발생")
}

// 에러 발생
```



## 에러 처리 방법
---

### try

```swift
do {
	let result1 = try checkingHeight(height: 200)
	// 결과 리턴 시 처리
} catch {
	// 에러 발생 시 처리
}
```

- `정상적인 경우`에는 <ins>정상 리턴 타입</ins>으로 리턴
- `에러가 발생한 경우`에는 <ins>에러를 throw</ins>
- `do-catch`문과 함께 사용해야 한다.

### try?

```swift
let result2 = try? checkingHeight(height: 200)
```

- 옵셔널 타입으로 리턴한다.
- `정상적인 경우`에는 <ins>정상 리턴 타입</ins>으로 리턴
- `에러가 발생한 경우`에는 <ins>nil</ins>로 리턴
- 옵셔널 바인딩을 한 후, 사용해야 한다.

### try!

```swift
let result3 = try! checkingHeight(height: 200)
```

- 강제
- `정상적인 경우`에는 <ins>정상 리턴 타입</ins>으로 리턴
- `에러가 발생하면` <ins>런타임 에러</ins>
- 에러가 날 수 없는 경우에만 사용해야 한다.



### Catch 블럭 처리법
`do 블럭에서 발생한 에러를 처리한다. 모든 에러를 반드시 처리해야 한다.`

**패턴이 있는 경우**
- 모든 에러를 각각 따로 처리해야 한다.

```swift
do {
	let isChecked = try checkingHeight(height: 100)
	print("놀이기구 탑승 가능: \(isChecked)")
} catch HeightError.maxHeight { // where절(에러 패턴 조건) 추가
	print("키가 커서 놀이기구 탑승 불가능")
} catch HeightError.minHeight { // catch {} 로 사용 가능
	print("키가 작아서 놀이기구 탑승 불가능")
}
```


**패턴이 없는 경우**
- 모든 에러가 넘어오기 때문에 catch문 내에서 각 에러에 따른 처리를 해주어야 한다.

```swift
do {
	let isChecked = try checkingHeight(height: 100)
	print("놀이기구 탑승 가능: \(isChecked)")
} catch { // 모든 에러가 넘어옴
	// error 상수를 제공
	// print(error.localizedDescription) // 바인딩 안 하고 사용 가능
	if let error = error as? HeightError { // 에러 타입(프로토콜)이 넘어오기 때문에 타입캐스팅 해줌
		switch error {
		case .maxHeight:
			print("키가 커서 놀이기구 탑승 불가능")
		case .minHeight:
			print("키가 작아서 놀이기구 탑승 불가능")
		}
	}
}
```

- catch문 내에 `error 상수`를 제공하기 때문에, 위와 같이 바인딩을 하지 않고 `print(error)`를  바로 사용할 수도 있다.
- `print(error.localizedDescription)` 코드를 사용하면 앱의 지역 설정에 따라 에러를 출력할 수 있다.


**Swift 5.3 에러 케이스 나열**
- catch 뒤에 에러 케이스를 나열하여 사용할 수 있다.

```swift
do {
	let isChecked = try checkingHeight(height: 100)
	print("놀이기구 타는 것 가능: \(isChecked)")
} catch HeightError.maxHeight, HeightError.minHeight { // 케이스 나열
	print("놀이기구 타는 것 불가능")
}
```



## 에러를 던지는 함수를 처리하는 함수
---

```swift
// 에러 정의
enum SomeError: Error {
	case aError
}

// throwing 함수 구현 (테스트를 위해 무조건 에러를 throw하도록 함)
func throwingFunc() throws {
	throw SomeError.aError
}
```

다음과 같은 throwingFunc()이 있다고 할 때, 에러 처리를 해보자.


### throwing 함수로 에러 다시 던지기
- 함수 내부에서 에러 처리를 직접 하지 못하는 경우, 에러를 다시 던질 수 있다.

```swift
func handleError1() throws {
	do { // 사실 이 경우에는 do도 생략할 수 있음
		try throwingFunc()
	} // ✨ catch 블럭이 없어도 에러를 던질 수 있음
}

do {
	try handleError1()
} catch {
	print(error.localizedDescription)
}
```

### rethrowing 함수로 에러 다시 던지기
- `rethrows` 키워드를 사용한다.
- `✨ 에러를 던지는 throwing 함수를 파라미터로 받는 경우`, 내부에서 다시 에러 던지기 가능


```swift
// 다시 에러를 던지는 함수
func someFuction1(callback: () throws -> Void) rethrows {
	try callback() // 에러를 다시 던짐 (직접 던지는 게 아님)
	// throw - // 직접 던지지 못함
}
```

```swift
// 다시 에러를 던지는 함수 - 에러 변환
func someFunction2(callback: () throws -> Void) rethrows {
	// 에러 정의
	enum ChangedError: Error {
		case cError
	}
	
	do {
		try callback()
	} catch { // catch문에서 throw 가능
		throw ChangedError.cError // 에러를 변환해서 다시 던짐
	}
}
```

```swift
// rethrowing 함수 처리
// throw 하기 때문에 try-catch로 처리
do {
	try someFunction1(callback: throwingFunc)
} catch {
	print(error)
}

do {
	try someFunction2(callback: throwingFunc)
} catch {
	print(error)
}

```



## 메서드/생성자에 throw 적용
---
`함수 뿐만 아니라, 메서드와 생성자에도 적용 가능`

```swift
// 에러 정의
enum NameError: Error {
	case noName
}

// 생성자와 메서드에서 적용
class Course {
	var name: String

	init(name: String) throws { // throwing 생성자
		if name = "" {
			throw NameError.noName // 에러 던짐
		} else {
			self.name = name
			print("수업을 올바르게 생성")
		}
	}
}

// 에러 처리
do {
	let _ = try Course(name: "스위프트5")
} catch NameError.noName {
	print("이름이 없어 수업 생성이 실패하였습니다.")
}
```

- throwing 생성자의 경우, try-catch 문을 사용하여 인스턴스를 생성하여야 한다.


### 생성자와 메서드의 재정의

```swift
class NewCourse: Course {
	// 재정의 시, throwing 생성자로 생성 필수
	override init(name: String) throws {
		try super.init(name: name) // 상위 클래스의 throwing 생성자 호출 시 try 키워드 필수
	}
}
```

- 상위 클래스의 throwing 생성자 재정의 시, throws/rethrows 키워드를 사용하여야 한다.
- 상위 클래스의 throwing 생성자를 호출할 때 try 키워드를 사용하여야 한다.


상속 관계에서
- (상위) throws ----- (하위) throws 재정의 ⭕️
- (상위) 일반 -------- (하위) throws 재정의 ⭕️
  (상위) throws ----- (하위) 일반 재정의 ❌
- (상위) throws ----- (하위) rethrows 재정의 ⭕️
  (상위) rethrows --- (하위) throws 재정의 ❌



## Defer문
---
`코드의 실행을 scope가 종료되는 시점으로 연기`
- 어떤 동작의 마무리 동작을 특정하기 위해 사용한다.

```swift
func deferStatement1() {
	defer {
		print("나중에 실행하기")
	}
	print("먼저 실행하기")
}

deferStatement1()
// 먼저 실행하기
// 나중에 실행하기
```

- print("먼저 실행하기")가 먼저 실행되고, defer문 내의 print("나중에 실행하기")가 실행된다.



```swift
func deferStatement2() {
	if true { // 무조건 실행되는 조건
		print("먼저 실행하기")
		return
	}
	
	defer { // defer문이 호출되지 않기 때문에 연기 또한 불가능
		print("나중에 실행하기")
	}
}

deferStatement2()
// 먼저 실행하기
```

- if true문 내의 return으로 함수가 종료되기 때문에, defer문이 호출되지 않는다.
- defer문이 호출되지 않았기 때문에 실행 연기 또한 되지 않음으로, 해당 코드에서 "나중에 실행하기"는 출력되지 않는다.


```swift
func deferStatement3() {
	defer {
		print(1)
	}
	defer {
		print(2)
	}
	defer {
		print(3)
	}
}

// 3
// 2
// 1
```

- defer문을 여러 개 사용하였을 때, 호출한 순서의 역순으로 실행한다.
- `하나의 defer문만 사용하는 것이 좋다.`


*for문에서도 사용 가능*

```swift
for i in 1...3 {
	defer { print("Defer된 숫자: \(i)") }
	print("for문의 숫자: \(i)")
}

// for문의 숫자: 1
// Defer된 숫자: 1
// for문의 숫자: 2
// Defer된 숫자: 2
// for문의 숫자: 3
// Defer된 숫자: 3
```

- 다음 주기로 넘어가기 전에 defer문을 실행한다.

