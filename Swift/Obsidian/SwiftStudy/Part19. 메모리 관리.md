> 힙 영역에 할당된 데이터가 해제되지 않으면, `메모리 누수 현상`이 발생
> 관리가 필요


### RC(Reference Count)
`나(인스턴스)를 가르키는 것의 개수`

## MRC(Manual Reference Counting)
- `수동`
- 메모리 관리 코드(retain, release)를 `직접 구현`하여 RC의 값을 변경해주어야 한다.
- Objective-C

## ARC(Automatic Reference Counting)
- `자동`
- 컴파일러가 메모리 관리 코드(retain, release)를 `자동으로 추가`해준다.
- Objective-C, Swift

```swift
class Dog {
	var name: String
	var weight: Double
	
	init(name: String, weight: Double) {
		self.name = name
		self.weight = weight
	}
	
	deinit {
		print("\(name) 메모리 해제")
	}
}

var choco: Dog? = Dog(name: "초코", weight: 15.0) // retain(choco) RC: 1
var bori: Dog? = Dog(name: "보리", weight: 10.0) // retain(bori) RC: 1

choco = nil
// release(choco) RC: 0
// 초코 메모리 해제
bori = nil
// release(bori) RC: 0
// 보리 메모리 해제
```


### *소유 정책과 참조 카운팅*

**소유 정책**
- 인스턴스는 하나 이상의 소유자가 있는 경우, 메모리에 유지된다.
**참조 카운팅**
- 인스턴스(자신)을 가르키고 있는 소유자 수


## 강한 참조 사이클 - 메모리 누수

```swift
class Dog {
	var name: String
	var owner: Person?

	init(name: String) {
		self.name = name
	}

	deinit() {
		print("\(name) 메모리 해제")
	}
}

class Person {
	var name: String
	var pet: Dog?

	init(name: String) {
		self.name = name
	}

	deinit() {
		print("\(name) 메모리 해제")
	}
}

var choco: Dog? = Dog(name: "초코") // 초코 RC: 1
var gildong: Person? Person(name: "홍길동") // 홍길동 RC: 1

choco?.owner = gildong // 홍길동 RC: 2
gildong?.pet = choco // 초코 RC: 2
// 강한 참조 발생

choco = nil // 초코 RC: 1
gildong = nil // 홍길동 RC: 1
// nil을 할당해도 메모리에서 해제되지 않음
```

- choco 인스턴스의 owner 프로퍼티가 gildong을 가르키므로 gildong의 RC가 +1이 된다.
- gildong 인스턴스의 pet 프로퍼티가 choco를 가르키므로 choco의 RC가 +1이 된다.
- 이런 경우, `강한 참조 사이클`이 발생하게 된다.
- 변수의 참조에 nil을 할당해도 메모리 해제가 되지 않아 `메모리 누수(Memory Leak)`가 발생한다.

- 메모리 해제를 정상적으로 한다면 다음과 같이 해주어야 한다.
 
```swift
choco?.owner = nil // 홍길동 RC: 1
gildong?.pet = nil // 초코 RC: 1

choco = nil // 초코 RC: 0 -> 메모리 해제
// 초코 메모리 해제
gildong = nil // 홍길동 RC: 0 -> 메모리 해제
// 홍길동 메모리 해제
```



## 메모리 누수 해결 방법

### 1. 약한 참조
`Week Reference`

- `weak` 키워드 사용
- 참조 시, RC 값을 올리지 않는다.
- 참조하고 있는 인스턴스가 사라지면, `nil로 초기화된다.`

```swift
class Dog {
	var name: String
	weak var owner: Person? // 약한 참조

	init(name: String) {
		self.name = name
	}

	deinit() {
		print("\(name) 메모리 해제")
	}
}

class Person {
	var name: String
	weak var pet: Dog? // 약한 참조

	init(name: String) {
		self.name = name
	}

	deinit() {
		print("\(name) 메모리 해제")
	}
}

var choco: Dog? = Dog(name: "초코") // 초코 RC: 1
var gildong: Person? Person(name: "홍길동") // 홍길동 RC: 1

choco?.owner = gildong // 홍길동 RC: 1
gildong?.pet = choco // 초코 RC: 1
// weak 키워드 사용으로 RC가 올라가지 않음

choco = nil // 초코 RC: 0 -> 메모리 해제
// 초코 메모리 해제

gildong?.pet // 참조하고 있는 인스턴스가 nil이 되었기 때문에 nil이 됨

gildong = nil // 홍길동 RC: 0 -> 메모리 해제
// 홍길동 메모리 해제
```

- choco 인스턴스가 nil이 되면, gildong의 pet 프로퍼티의 값 또한 nil이 된다.


### 2. 비소유 참조
`Unowned Reference`

- `unowned` 키워드 사용
- 참조 시, RC 값을 올리지 않는다.
- 참조하고 있는 인스턴스가 사라져도, `nil로 초기화되지 않는다.`

```swift
class Dog {
	var name: String
	unowned var owner: Person? // 비소유 참조

	init(name: String) {
		self.name = name
	}

	deinit() {
		print("\(name) 메모리 해제")
	}
}

class Person {
	var name: String
	unowned var pet: Dog? // 비소유 참조

	init(name: String) {
		self.name = name
	}

	deinit() {
		print("\(name) 메모리 해제")
	}
}

var choco: Dog? = Dog(name: "초코") // 초코 RC: 1
var gildong: Person? Person(name: "홍길동") // 홍길동 RC: 1

choco?.owner = gildong // 홍길동 RC: 1
gildong?.pet = choco // 초코 RC: 1
// weak 키워드 사용으로 RC가 올라가지 않음

choco = nil // 초코 RC: 0 -> 메모리 해제
// 초코 메모리 해제

// gildong.pet // ERROR. 참조하고 있는 인스턴스가 사라져도 nil이 되지 않기 때문
gildong?.pet = nil // 에러가 나지 않도록 nil로 초기화해주어야 함

gildong = nil // 홍길동 RC: 0 -> 메모리 해제
// 홍길동 메모리 해제
```

- choco 인스턴스가 nil이 되어도, gildong의 pet 프로퍼티의 값이 nil이 되지 않는다.
- 따라서, gildong의 pet에 접근하면 에러가 발생한다.


> weak와 unowned 정리

|     |                    Weak Reference                     |                           Unowned Reference                            |
| :-: | :---------------------------------------------------: | :--------------------------------------------------------------------: |
| 방식  |                       weak 키워드                        |                              unowned 키워드                               |
| 예시  |           weak var pet: Dog?<br>(nil 자동 할당)           |    unowned var pet: Dog?<br>(Swift 5.3 이후, 옵셔널 선언 가능. nil 자동 할당 X)     |
| 공통점 |                  강한 참조 제거 (RC를 안 올림)                  |                          강한 참조 제거 (RC를 안 올림)                           |
| 차이점 | 소유자에 비해 짧은 생명주기를 가진<br>인스턴스 참조 시 주로 사용<br>(nil 확인 가능) | 소유자보다 인스턴스의 생명주기가 더 길거나,<br>같은 경우에 사용<br>(nil 확인 불가능. 인스턴스 해제 시 에러 발생) |

> weak, unowned 키워드를 이용하여 선언할 시 주의점

|                |           let           | var |      Optional       |     Non-Optional      |
| :------------: | :---------------------: | :-: | :-----------------: | :-------------------: |
| strong<br>(기본) |            O            |  O  |          O          |           O           |
|      weak      | X<br>(nil로 변경될 가능성이 있음) |  O  |          O          | X<br>(nil 할당이 가능해야 함) |
|    unowned     |            O            |  O  | O<br>(Swift 5.3 이후) |           O           |
- *`weak var`를 주로 사용한다.*



## 클로저와 메모리 관리 ✨

> 코드를 보고 동작 방법을 이해할 수 있도록 공부하자.

### 캡처 현상
`클로저 내부에서 외부 변수를 사용해야 하면, 캡처 현상 발생`

```swift
// 일반적인 함수
func calculate(number: Int) -> Int {
	var sum = 0
	
	func square(num: Int) -> Int {
		sum += (num * num)
		return sum
	}
	
	let result = square(num: number)
	return result
}

calculate(10) // 100
calculate(20) // 400
calculate(30) // 900
```

```swift
// 중첩 함수
func calculateFunc() -> ((Int) -> Int) {
	var sum = 0
	
	func square(num: Int) -> Int {
		sum += (num * num) // square의 외부 변수 sum
		return sum
	}
	return square // 함수 리턴
}

// 함수를 변수에 할당하면, 클로저와 같이 동작 (Heap 메모리에 저장)
var squareFunc = calculateFunc()

squareFunc(10) // 100
squareFunc(20) // 500
squareFunc(30) // 1400
```

- 함수를 리턴하는 calcuateFunc()을 변수 squareFunc에 저장하면, 이는 클로저를 찍어내는(만드는) 형태로 작동하게 된다.
- 클로저와 같이 동작하기 때문에 squareFunc이 Heap 메모리에 올라간다.
- sqaureFunc은 내부 함수 square의 메모리 주소(코드)을 갖는다.
- 그리고 square에서는 외부 변수 sum을 가지고 있어야 하기 때문에 여기서 `캡처 현상`이 발생한다.
- `(squareFunc 내에 새로 sum 변수를 만들고 값을 캡처해서 사용)`

- 위 코드에서는 squareFunc 변수에 저장했을 때 캡처 현상으로 sum 변수가 생기게 되고,
- squareFunc(10) 이후 sum은 100, squareFunc(20) 이후 sum은 100+400 으로 500이 되는 식이다.


### 캡처 리스트
`값 타입 캡처로 값 변경 방지. 강한 참조 해결`

```swift
// 파라미터가 없는 경우
{ [캡처리스트] in

}

// 파라미터가 있는 경우
{ [캡처리스트] (파라미터) -> 리턴형 in

}
```


*캡처 현상과 캡처 리스트의 차이*

```swift
var num = 1
let valueCaptureClosure = {
	print("밸류값 출력(캡처): \(num)")
}

num = 7
valueCaptureClosure() // 밸류값 출력(캡처): 7

num = 1
valueCpatureClosure() // 밸류값 출력(캡처): 1

let valueCaptureListClosure = { [num] in
	print("밸류값 출력(캡처리스트): \(num)")
}

num = 7
valueCaptureListClosure() // 밸류값 출력(캡처리스트): 1

```

**캡처 현상**
- valueCaptureClosure는 클로저로, 힙 영역에 할당 됨
- 힙 영역에 할당될 때, 스택에 있는 num의 `메모리 주소`를 valueCaptureClosure가 가지게 됨
- 따라서, 스택에 있는 num 변수의 값이 바뀌면 바뀐 값이 나오게 되는 것

**캡처 리스트**
- valueCaptureListClosure는 클로저로 힙 영역에 할당 됨
- 힙 영역에 할당될 때, 스택에 있는 num의 `값`을 valueCaptureListClosure가 가지게 됨
- 따라서, 스택에 있는 num의 변수의 값이 바뀌어도 값이 바뀌지 않음


### 참조와 캡처리스트

- 캡처리스트에 강한 참조가 이루어지면, 외부 요인에 의해 인스턴스 해제가 되는 상황을 방지할 수 있다.
  (= RC를 올려서 메모리 해제를 방지하는 것)
- 캡처리스트 사용 시 `weak`, `unowned` 사용하여 약한 참조가 가능하다.

```swift
class SomeClass {
	var num = 0
}

var x = SomeClass()
var y = SomeClass()

let refTypeCapture = { [x] in // 캡처리스트로 x 캡처
	print("참조 출력값(캡처리스트):", x.num, y.num)
}

x.num = 1
y.num = 1

print("참조 초기값(숫자변경후):", x.num, y.num) // 참조 초기값(숫자변경후): 1 1
refTypeCapture() // 참조 출력값(캡처리스트): 1 1
print("참조 초기값(클로저실행후):", x.num, y.num) // 참조 초기값(클로저실행후): 1 1
```

- 둘 다 바뀐 값으로 나오지만, 가지고 있는 것이 다르다.
- refTypeCapture에서 캡처리스트를 통해 x를 캡처함 -> `x 변수에 들어있는 인스턴스의 주소값`을 캡처
- refTypeCapture에서 캡처현상을 통해 y가 캡처됨 -> `변수 y의 주소값`을 캡처


### 강한 참조와 캡처 리스트

```swift
// 강한 참조 사이클이 일어나는 예제 아님
var z = SomeClass()

let refTypeCapture1 = { [weak z] in // weak로 선언하면, nil을 포함할 수 있어야 함 (무조건)
	print("참조 출력값(캡처리스트):", z?.num) // z는 옵셔널 타입
}

refTypeCapture1() // 참조 출력값(캡처리스트): Optional(0)

let refTypeCapture2 = { [unowned z] in // unowned는 nil로 변환 안 해줌
	print("참조 출력값(캡처리스트):", z.num) // z는 옵셔널 타입 X
}

refTypeCapture2() // 참조 출력값(캡처리스트): 0
```

- `weak`는 가르키는 인스턴스가 없을 경우, 자동으로 nil을 할당해준다. 따라서, nil이 들어갈 수 있도록 옵셔널 타입으로 사용되게 된다.
- `unowned`는 가르키는 인스턴스가 없어도 nil을 자동할당해주지 않는다.


### 캡처 리스트 내 바인딩
- 외부변수와 헷갈리지 않게, 내부에서 변수명을 변경해서 사용

```swift
var s = SomeClass()

let captureBinding = { [z = s] in
	print("바인딩의 경우:", z.num)
}

let captureWeakBinding = { [weak z = s] in // weak로 선언
	print("Weak 바인딩의 경우:", z?.num) // 옵셔널 타입
}

captureBinding() // 바인딩의 경우: 0
captureWeakBinding() // Weak 바인딩의 경우: Optional(0)
```


### 객체 내의 클로저

- 클로저 내에서 인스턴스의 속성 및 메서드에 접근하고자 할때, `self` 키워드를 <ins>반드시</ins> 사용해야 한다.
- Swift 5.3 이후 `[self]`를 사용할 수 있다.
- Swift 5.3 이후, 구조체에서는 self를 생략할 수 있다.

```swift
class Dog {
	var name = "초코"

	func doSomething() {
		// 비동기적으로 실행하는 클로저
		// 멀티스레딩 - 스택에서 클로저를 사용해야 하기 때문에 Heap 영역에 올라감
		DispatchQueue.global().async {
			print("나의 이름은 \(self.name)입니다.")
		}
	}
}
```

- 위 코드에서 `DispatchQueue` 사용으로 해당 클로저가 다른 스택에서 동작하게 된다.
- 따라서, 클로저는 Heap 영역에 할당되게 되며 인스턴스의 메모리 주소를 캡처한다.
- 이때, 객체의 속성이나 메서드를 사용하는 경우 `self` 키워드를 사용하여 강한 참조(RC +1)가 이루어지고 있음을 나타내야 한다.
- 강한 참조 사이클를 방지하기 위해 `[weak self]` 와 같이 약한 참조로 선언할 수 있다. (비소유 참조도 가능)
- 스레드(스택)에서 클로저가 종료되면, 클로저는 Heap에서 메모리가 해제된다. (클로저의 RC가 0이면 자동 해제)


- 추가 예제

```swift
class Person {
	let name = "홍길동"

	func sayMyName() {
		print("나의 이름은 \(name)입니다.")
	}
	func sayMyName1() {
		// 클로저가 Heap에 올라감
		DispatchQueue.global().async {
			print("나의 이름은 \(self.name)입니다.") // 강한 참조
		}
	}
	func sayMyName2() {
		// 클로저가 Heap에 올라감
		DispatchQueue.global().async { [weak self] in // 약한 참조
			print("나의 이름은 \(self?.name)입니다.") // Optional
		}
	}
	func sayMyName3() {
		// 클로저가 Heap에 올라감
		DispatchQueue.global().async { [weak self] in // 약한 참조
			guard let weakSelf = self else { return } // 옵셔널 바인딩
			print("나의 이름은 \(weakSelf.name)입니다. (가드문)")
		}
	}
}

let person = Person()
person.sayMyName() // 나의 이름은 홍길동입니다.
person.sayMyName1() // 나의 이름은 홍길동입니다.
person.sayMyName2() // 나의 이름은 Optional("홍길동")입니다.
person.sayMyName3() // 나의 이름은 홍길동입니다.
```

- `[weak self]` 사용 시, `guard`문을 주로 같이 사용한다.


### 메모리 누수(Memory Leak)의 사례

```swift
class Dog {
	var name = "초코"
	var run: (() -> Void)?

	func walk() {
		print("\(self.name)가 걷는다.")
	}

	func saveClosure() {
		run = { // 클로저를 변수에 저장
			print("\(self.name)가 뛴다.") // 강한 참조
			// choco RC +1
		}
		// run RC +1
	}

	deinit { // 소멸자
		print("\(self.name) 메모리 해제")
	}
}

func doSomething() {
	let choco: Dog? = Dog() // choco RC +1
	choco?.saveClosure() // choco RC: 2, run RC: 1
}

doSomething()
// choco RC -1
// choco RC: 1, run RC: 1
```

1. doSomething 함수 내 `choco?.saveClosure()` 코드가 없을 때
- Dog 클래스의 `인스턴스를 생성`하여 choco 변수에 저장한다. 따라서 인스턴스의 RC가 1 증가한다.
- `doSomething함수가 종료`되면, choco 변수의 메모리를 해제하기 때문에 인스턴스의 RC가 1 감소한다.
- 인스턴스의 소멸자(deinit)가 호출된다.

2. doSomething 함수 내 `choco?.saveClosure()` 코드가 있을 때
- Dog 클래스의 `인스턴스를 생성`하여 choco 변수에 저장한다. 따라서 인스턴스의 RC가 1 증가한다.
- `saveClosure` 내에서 클로저를 변수 run에 저장하고 있다. 따라서 인스턴스의 RC 가 1 증가한다.
- `run` 변수는 힙에 생성된 클로저의 메모리 주소를 가르키고 있기 때문에, 클로저의 RC가 1 증가한다.
- `doSomething 함수가 종료`되면, choco 변수의 메모리를 해제하기 때문에 인스턴스의 RC가 1 감소한다.
- 클로저의 RC는 1이기 때문에, 메모리에서 해제되지 않는다.
- 인스턴스의 RC는 1이기 때문에, 메모리에서 해제되지 않는다.


### 캡처 리스트 실제 사용 예시

```swift
// 강한 참조 사이클이 일어나는 예시는 아님
class ViewController: UIViewController {
	var name: String = "뷰컨트롤러"

	func doSomething() {
		// 클로저 Heap에 할당
		DispatchQueue.global().async {
			sleep(3)
			print("글로벌 큐에서 출력하기: \(self.name)") // 강한 참조
			// vc RC +1
		}
	}

	deinit() {
		print("\(name) 메모리 해제")
	}
}

func localScopeFunction() {
	let vc = ViewController() // vc RC +1
	vc.doSomething() // vc RC: 2
}

localScopeFunction()
// localScopeFunction 함수 종료 후, vc RC -1
// 글로벌 큐에서 출력하기: 뷰컨트롤러 ------------- sleep(3) 영향
// doSomething 함수 종료 후, vc RC -1
// vc RC: 0
// 뷰컨트롤러 메모리 해제
```

- `localScopeFunction` 함수가 종료되는 시점에 인스턴스의 RC가 -1되어 RC의 값은 1이다. (강한 참조 중)
- 따라서, 바로 소멸되지 않는다.
- 시간이 지나 `DispatchQueue`가 종료된 이후에 클로저와 인스턴스의 RC가 -1이 된다.
- 인스턴스와 클로저의 RC가 각각 0이기 때문에 메모리에서 해제된다.

```swift
class ViewController1: UIViewController {
	var name: String = "뷰컨트롤러"

	func doSomething() {
		DispatchQueue.global().async { [weak self] in // 약한 참조
			sleep(3)
			print("글로벌 큐에서 출력하기: \(self?.name)") // Optional
		}
	}

	deinit() {
		print("\(name) 메모리 해제")
	}
}

func localScopeFunction1() {
	let vc = ViewController()
	vc.doSomething()
}

localScopeFunction1()
// localScopeFunction1 함수 종료 후, vc RC -1
// vc RC: 0
// 뷰컨트롤러 메모리 해제
// 글로벌 큐에서 출력하기: nil ------------ sleep(3) 영향
```

- 약한 참조가 이루어졌기 때문에, `localScopeFuntion1`이 종료되는 순간 인스턴스의 RC가 0이 되어 메모리에서 해제가 이루어진다.
- 소멸자가 호출된다.
- `DispatchQueue`에서 캡처리스트를 통해 인스턴스의 메모리 주소를 캡처했기 때문에, 이미 해제된 인스턴스에 접근함으로 nil이 나오게 된다.
- DispatchQueue 동작 종료 후, 클로저도 메모리에서 해제된다.

