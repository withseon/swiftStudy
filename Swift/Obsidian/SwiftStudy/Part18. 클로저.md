스위프트는 "함수"를 일급객체로 취급
`함수는 타입이다.`
1. 함수를 변수에 할당 가능(변수로 실행할 땐, 파라미터 이름 필요 없음)
2. 함수를 호출할 때, 함수를 파라미터로 전달 가능
3. 함수에서 함수 반환 가능

## 클로저

특징
1. 리턴 타입 생략 가능
2. 앞에서 타입 명시적으로 적어놔서 타입 추론이 가능하다면, 클로저 내 파라미터의 타입 생략 가능
```
// 함수
func add(a: Int, b: Int) -> Int {
	let result = a + b
	return result
}

// 클로저
let _ = { (a: Int, b: Int) in
	let result = a + b
	return result
}

// 클로저 타입 생략
let _: (Int, Int) -> Int = { (a, b) in
	let result = a + b
	return result
}
```

3. 파라미터의 타입 생략도 대부분 가능 ( 컴파일러가 타입 추론 가능한 경우)
```
let closureType4 = { param in
	// 컴파일러가 타입 추론 가능
	return param + "!"
}
```


## 클로저를 사용하는 이유

이름이 없는 이유
`함수를 실행할 때, 전달하는 형태로 사용하기 때문`
ex) 함수의 파라미터를 클로저로 전달

클로저를 쓰는 이유
1. 함수를 실행할 때, 파라미터로 클로저를 정의하면서 전달하기 위해
2. 사후적으로 클로저를 정의할 수 있다.
	 미리 함수를 정의하고 사용하는 게 아니고, 사후적으로 만들고 싶은 함수를 정의할 수 있기 때문에 활용도가 높다.

콜백함수
함수를 실행할 때 파라미터로 실행하는 함수 -> Callback을 받기 때문에 콜백 함수
콜백(= 나중에 다시 부르기 때문에 붙여진 이름)

## 클로저 문법 최적화
1. 문맥상 파라미터와 리턴 타입 추론 (생략 가능)
2. 싱글 익스프레션인 경우, return키워드 생략 가능
3. 아규먼트 이름 축약 가능 -> $0, $1
4. 트레일링 클로저 문법: 함수의 마지막 전달 인자(아규먼트)인 경우 소괄호 생략 가능

## 클로저 실제 사용 예시

콜백 함수의 이름을 completion(completionHandler)이라고 짓는 경우
: 동작이 완료되고 나서 실행할 무언가의 함수로 사용한다는 뜻

콜백 함수
함수를 실행하면서 파라미터로 전달하는 함수
주로 함수가 실행된 결과는 콜백 함수로 전달받아 처리

멀티플 트레일링 클로저 - Swift 5.3
예전에는 클로저 여러 개로 파라미터를 사용할 때, 마지막 클로저만 소괄호 생략할 수 있었다.
이제는 소괄호 다 생략할 수 있고, 첫번재 아규먼트도 생략할 수 있다.

## 클로저의 메모리 구조
	아래의 코드에 대해 메모리 구조와 함께 생각해보기.

클로저의 캡처 현상
= 클로저에서 저장할 필요가 있는 값을 캡처해서 값을 저장 1) 값을 저장 or 2) 참조를 저장

```
var stored = 0

let closure = { (number: Int) -> Int in
    stored += number
    return stored
}

closure(3) // 3
closure(4) // 7
```


1. 일반적인 함수와 중첩 함수 (값을 리턴)
```
func calculate(number: Int) -> Int {
	var sum = 0
	
	func square(num: Int) -> Int {
		sum += (num * num)
		return sum
	}
	
	let result = square(num: number)
	return result
}

calculate(number: 10) // 100
calculate(number: 20) // 200
calculate(number: 30) // 300
```


2. 중첩 함수(함수를 리턴)
```
func calculateFunc() -> ((Int) -> Int) {
	var sum = 0
	
	func square(num: Int) -> Int {
		sum += (num * num)
		return sum
	}
	
	return square
}

// 변수에 저장하는 경우(Heap 메모리에 유지)
var squareFunc = calculateFunc()

squareFunc(10) // 100
squareFunc(20) // 500
squareFunc(30) // 1400

// 변수에 저장하지 않는 경우
calculateFunc()(10) // 100
calculateFunc()(20) // 200
calculateFunc()(30) // 900

// 래퍼런스 타입
var dodoFunc = squareFunc
dodoFunc(20) // 1800
```


### 클로저의 메모리 구조 정리

> 1. 함수를 변수에 할당하거나
> 2. 클로저를 사용하는 경우
> 힙(Heap)에 해당 메모리 주소를 저장 및 (외부의) 필요한 변수를 캡처


## escaping / autoclosure 키워드
원칙적으로 함수의 실행이 종료되면 클로저도 제거됨

###  non-escaping
함수 내부에서 단순하게 실행하고 종료할 때. 클로저를 Heap에 저장할 필요가 없음

### @escaping
클로저를 제거하지 않고 함수에서 탈출시킴 (함수가 종료되어도 클로저가 존재)
-> 클로저가 함수의 실행흐름(스택 프레임)을 벗어날 수 있도록 함

	함수에 주소를 만들어서 클로저를 Heap에 찍어내고 그 주소값을 외부 변수에 저장
	함수의 실행을 벗어나서도 사용 (메모리 관리 필요)


1. 어떤 함수 내부에 존재하는 클로저(함수)를 외부 변수에 저장(할당)
2. GCD (비동기 코드의 사용)
```
func performEscaping1(closure: @escaping (String) -> ()) {

	var name = "홍길동"
	
	//1초뒤에 실행하도록 만들기
	DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
		closure(name)	
	}
}

performEscaping1 { name in
	print("이름 출력하기: \(name)")
}
```

	DispatchQueue에서 closure가 1초뒤에 실행하도록 작성된 코드
	이는 함수가 종료된 이후에 클로저가 동작해야 함
	이런 경우에는 @escaping 사용

## @autoclosure 
자동으로 클로저를 만들어줌

```
func someFunction(closure: @autoclosure () -> Bool) {
	if closure() {
		print("참입니다.")
	} else {
		print("거짓입니다.")
	}
}

var num = 1
// someFunction(closure: Bool)
someFunction(closure: num == 1)
```

	파라미터가 없는 클로저만 가능
	autoclosure가 자동으로 {}(중괄호)를 붙여(래핑해서) 클로저처럼 사용할 수 있게 함
	
	일반적으로 클로저 형태를 써도 되지만, 너무 번거로울 때 사용
	실제 코드가 명확해 보이지 않을 수 있으므로 사용 지양 (애플 공식 문서)
	잘 사용하지 않음. 읽기 위한 문법
	
	기본적으로 non-escaping 특성을 가지고 있음
	escaping 처럼 사용하려면 @authclosure @escaping 으로 써야 함

## 클로저의 사용법

UIKit의 코드로 UI 작성 시, 속성 선언을 클로저로 직접 실행해서 해당 타입 반환
	- 연관성이 있는 코드들을 묶어둘 수 있어서 가독성이 높아짐 