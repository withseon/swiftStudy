	## 함수의 기본 개념
---
어떠한 기능을 하는 코드 모음. (정의 + 실행)의 2단계로 구성

	1. 반복되는 동작 단순화해서 재사용 가능
	2. 코드의 논리적 단위 구분 가능
	3. 코드 길이 단순화
	4. 함수를 잘 만들어 두면 내부 내용을 몰라도 사용 가능

### 함수의 input이 있는 경우

파라미터(Parameter) / 매개변수 / 인자
	함수의 정의에 입력값으로 사용되는 변수(상수)

아규먼트(Argument) / 인수
	함수의 호출에 사용되는 실제 값
	파라미터로 들어가는 실질적인 값

### 함수의 output이 있는 경우 = 결과로 "값"이 있는 것

리턴(return)

### 함수의 input과 output이 모두 있는 경우

### Void 타입의 이해
= output이 없는 경우 '-> Void' 생략

## 함수의 응용
---

### 아규먼트 레이블

```
func printName1(first name: String) {
	print("이름은 \(name)입니다.")
}

printName1(first: "Miya")
```
	 함수에 아규먼트를 전달할 때, 밖에서 볼 때는 first라고 사용하고
	 함수의 내부에서 사용할 때는 name으로 사용
	 
	 장점
	 함수를 호출할 때 구체적으로 명시를 하면서, 내부에서는 간단하게 사용할 수 있음

### 아규먼트 레이블의 생략 (와일드 카드 패턴)

```
func addPrintFunction(_ firstNum: Int, _ secondNum: Int) {
	print(firstNum + secondNum)
}

addPrintFunction(1, 2)
```
	

## 가변 파라미터

	함수의 파라미터에 정해지지 않은, 여러 개의 값을 넣는 것도 가능
	
	1. 하나의 파라미터로 2개 이상의 아규먼트 전달 가능
	2. 아규먼트는 배열 형태로 전달
	3. 가변 파라미터는 개별 함수마다 하나씩만 선언 가능 (선언 순서는 상관 X)
	4. 가변 파라미터는 기본값을 가질 수 없음

```
func arithmeticAverage(_ numbers: Double...) -> Double {
	var total = 0.0
	for n in numbers {
		total += n
	}
	return total / Double(numbers.count)
}

arithmeticAverage(1.5, 2.5, 3.5, 4.5)
// 와일드 카드 패턴 안 쓰면
// arithmeticAverage(numbers: 1.5, 2.5, 3.5, 4.5)
```

### 파라미터 기본값 설정

```
func numMultiple(num1: Int, num2: Int = 1) -> Int {
	let result = num1 * num2
	return result
}

numMultiple(num1: 2) // 2
numMultiple(num1: 2, num2: 5) // 10
```


## 함수 사용시 주의점
---
### 함수의 파라미터에 대한 정확한 이해

	파라미터는 함수 내부에서 `let(상수)`으로 선언되었다고 볼 수 있다.
	함수 내부에서 파라미터의 값을 변경할 수 없다.
	변경하고 싶다면, 변수를 선언해서 파라미터의 값을 할당하여 사용

### 함수 내 변수의 Scope(스코프)

	함수 내에서 선언한 변수는 함수의 바디(중괄호 안)에서만 사용

### return 키워드에 대한 정확한 이해

	return 키워드의 역할
		1. output이 있는 함수: 결과를 리턴하며 함수 벗어남
		2. output이 없는 함수: 함수 실행 중지 및 함수 벗어남

```
// 리턴타입이 없는데 return 사용
func numberPrint(n num: Int) {
	if num >= 5 {
		print("숫자는 5이상입니다.")
		return
	}
	print("숫자가 5미만입니다.")
}

// numberPrint의 아규먼트가 5 이상이면
// "숫자는 5이상입니다." 출력하고 함수 벗어남
```

### 리턴 타입이 있는 경우, 함수의 실행문

	리턴타입이 있는 함수 호출 시, 함수 호출은 표현식

### 함수의 중첩 사용 (Nested Functions)

	함수 내부에서 작성된 함수는 외부에서 사용 불가능
	함수를 제한적으로 사용하고 싶을 때 사용


## 함수의 표기법(지칭) / 함수의 타입  표기
---
### 함수의 표기법(지칭)

```
func doSomething() {

}

func numberPrint(n num Int) {

}

func chooseStepFunction(backward: Boot, value: Int) {

}
func addPrintFunction(_ : Int, _) {

}

var some1 = doSomething // doSomething 함수를 가르킴
var some2 = numberPrint(n:) // 아규먼트 레이블이 있는 경우, 아규먼트 레이블까지를 함수 이름으로 봄
var some3 = chooseStepFunction(backward: value:) // 파라미터가 여러개인 경우, 콤마 없이 아규먼트 이름과 클론 표기
var some4 = addPrintFunction(_:_:) // 아규먼트 레이블이 생략된 경우, 아래와 같이 표기
```

	함수의 지칭이 필요한 이유
	1. 어떠한 변수에 담는 경우
	2. 개발자 문서 표시가 그렇게 되어있기 때문에

### 함수의 타입 표기

```
// 함수의 타입 표기 방법
var function1: (Int) -> () = numberPrint(n:)
var function2: (Int, Int) -> Void = addPrintFuction(_:_:)
```


## 함수의 오버로딩
---
	같은 이름의 함수에 파라미터를 다르게 선언
	`함수 이름의 재사용`

```
func doSomething(value: Int) {
	print(value)
}

func doSomething(value: Dobule) {
	print(value)
}

func doSomething(_ value: Int) {
	print(value)
}

func doSomething(value1: Int, value2: Int) -> Int {
	return value1 + value2
}
```

함수를 식별할 때
	함수 이름, 파라미터 수/자료형, 아규먼트 레이블, 리턴형을 모두 포함해서 함수 식별


## 범위(Scope)에 대한 이해
---
Scope - 함수, if문, for문 등 모두 해당

	1. 변수는 코드에 선언되어야 접근 가능 (전역변수 예외)
	2. 상위 스코프에 선언된 변수는 접근 가능. 하위 스코프는 불가능
	3. 서로 다른 스코프에 동일한 이름의 변수/상수 존재 가능. 그 중 인접한 스코프에 있는 변수/상수 접근



## 제어전송문 정리
---
### break
	switch문: case문에 실행할 게 없으면 사용
	for/while문: 인접한 반복문 중지

### fallthrough
	switch문: cas문 실행을 하고, 그 아래 case문 실행

### continue
	for/while문: 반복문을 다음 싸이클로 보냄

### return
	함수: 함수 중지. 자료형에 맞는 결과 반환


### throw
	에러가 발생가능하도록 정의된 함수: 함수 중지. 에러 타입 리턴



## 함수 실행의 메모리 구조
---
	함수 실행 시에는 함수 실행에 필요한 메모리 공간을 스택에 만들고
	함수 실행이 완료되면, 해당 스택 프레임이 사라짐
    
    그 외 파라미터나 리턴에 대한 메모리 구조에 대해 더 생각해보기


## 입출력(inout) 파라미터
---
함수 내 파라미터
	값 타입
	임시 상수이기 때문에 변경 불가

inout 파라미터
	함수 내에서 변수를 직접 수정
	참조로 전달
	변수 전달 시 `&` 붙여야 함 (원본이 전달된다는 의미)

```
// 함수 선언 시, inout 키워드 사용
func swapNumbers(a: inout Int, b: inout Int) {
	let temp = a
	a = b
	b = temp
}

num1 = 123
num2 = 456

// 함수 호출 시, & 사용
swapNumbers(a: &num1, b: &num2)

print("num1: \(num1), num2: \(num2)")
```

inout 파라미터 사용 시 주의사항

	1. 상수나 리터럴 전달 불가능
	2. 기본값 선언 불가
	3. 가변  파라미터 선언 불가

## guard문
---
if문 사용 시 조건이 여러 개일 때 가독성이 떨어지는 문제를 guard문 사용으로 극복

guard문 특징

	1. else문 먼저 배치
	2. 조건을 만족하는 경우 다음줄로 넘어가서 실행
	3. 가드문에서 선언된 변수를 아래문장에서 사용 (동일한 scope로 취급)

```
// if문 사용
func checkNumbersOf1(password: String) -> Bool {
	if password.count >= 6 {
		// 로그인 처리 코드
		return true
	} else {
		...
		return false
	}
}
```

```
// guard문 사용
func checkNumbersOf2(password: String) -> Bool {
	guard password.count >= 6 else {
		...
		return false
	}
	
	// 로그인 처리 코드
	return true
}
```

	먼저 감시를 해서 조건을 만족하지 않을 경우 else문을 먼저 실행
	`early exit`이 이루어짐 (함수를 종료시키는 return/throw가 들어가야 함)


## 함수의 리턴값과 discardableResult
---

|   리턴값이 없는 경우   |       리턴값이 있는 경우        |
| :------------: | :---------------------: |
|  결과로 값을 갖지 않음  |        결과로 값을 가짐        |
| 메모리 공간을 만들지 X  | 값을 반환하기 위한 임시 메모리 공간 만듦 |
| 함수 실행시 CPU 제어권 |  함수 실행시 CPU 제어권 + 리턴값   |

### @어트리뷰트 키워드

	컴파일러에게 추가적인 정보를 제공하는 키워드
	1. 선언에 추가적인 정보 제공
	2. 타입에 추가적인 정보 제공


```
// Swift 5.2 전
// 함수의 결과값 사용 생략
_ = doSomething()
```

	기존(Swift 5.2 전)에는 리턴이 있는 함수를 쓸 때, 리턴값이 필요 없으면 와일드 카드 패턴 사용
### @discardableResult

	버릴 수 있는 결과를 뜻함

```
@discardableResult
func doSomething() -> String {
	...
	return "Swift"
}

doSomething()
```


## 튜플을 사용하는 이유 - 함수와 연관
---

	함수는 리턴값이 한개만 존재
	따라서 여러 값을 반환하고 싶을 때, 튜플로 묶어서 반환
	(간단한 경우에 사용. 배열도 리턴 타입으로 쓸 수 있기 때문)
