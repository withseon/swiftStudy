
## 에러 처리 과정
---

첫번째, 어떠한 에러가 발생할 것인지를 정의한다.

```swift
enum HeightError: Error { // Error 프로토콜 채택
	case maxHeight
	case minHeight
}
```

- `Error` 프로토콜을 채택한 열거형으로 정의한다.


두번째, throwing 함수 구현

```swift
func checkingHeight(height: Int) throws -> Bool {
	if height > 190 {
		throw HeightError.maxHeight
	} else if height < 130 {
		throw HeightError.minHeight
	} else {
		if height >= 160 {
			return true
		} else {
			return false
		}
	}
}
```

- `throws(throw)` 키워드를 사용하여, 특정 조건에서 에러를 던질 수 있는 함수를 구현한다.


세번째, 에러 처리

```swift
do {
	let _ = try checkingHeight(height: 200)
	print("놀이기구 탑승 가능")
} catch {
	print("놀이기구 탑승 불가")
}

// 놀이기구 탑승 불가
```

- height가 200이기 때문에 checkingHeight() 에서 HeightError.maxHeight 에러를 던진다.
- `try-catch`문을 사용하여 던져진 에러를 받아 catch문의 print()를 실행하게 된다.

<br>
## Result
---
`결과를 넣은 타입`


> 애플 공식 문서에서 찾아볼 수 있는 Result 타입의 내부 구현

```swift
@frozen
enum Result<Success, Failure> where Failure : Error
```

- 제네릭을 사용하는 열거형으로 구현되어 있기 때문에 연관값이 반드시 있어야 한다.
- `case success(Success)`와 `case failure(Failure)`를 갖는다.
- Failure는 Error 프로토콜을 채택해야 한다.

*제네릭 열거형*
*제네릭 타입의 매개변수를 사용하여 case가 각각 다른 타입의 값을 가질 수 있게 하는 열거형*

<br>

### Result 타입을 사용하여 에러를 처리해보자

첫번째, Result 리턴 함수 구현

```swift
func resultTypeCheckingHeight(height: Int) -> Result<Bool, HeightError> {
	if height > 190 {
		return Result.failure(HeightError.maxHeight)
	} else if height < 130 {
		return Result.failure(HeightError.minHeight)
	} else {
		if height >= 160 {
			return Result.success(true) 
		} else {
			return Result.success(false)
		}
	}
}
```

- `throws(throw)` 키워드를 사용하지 않고, Result 타입을 리턴한다.


두번째, 에러 처리

```swift
let result = resultTypeCheckingHeight(height: 200)

// 처리
switch result {
case .success(let data): // 연관값을 바인딩
	print("결과값은 \(data)입니다.")
case .failure(let error):
	print(error)
}
```

- 함수의 리턴값을 result 변수에 저장한 후, `switch-case`문으로 각 Result 타입의 각 case(success, failure)에 따른 처리를 해준다.
- case의 연관값을 바인딩하여 case문 내에서 사용한다.

<br>

## Result 타입을 사용하는 이유
---
`성공과 실패의 경우를 깔끔하게 처리할 수 있기 때문에`

기존의 에러 처리는 단순히 데이터나 오류 메세지로만 구성이 되어 있다.
따라서, 실제 함수를 호출하는 곳에서 에러 형식을 특정 짓기 어렵다는 단점이 있다.

그에 반해 Result 타입은 함수 정의 시 에러 타입을 명시함으로써 `에러 형식을 특정 지을 수 있다.` (타입 캐스팅 불필요)
성공과 실패에 대한 두 가지 case를 사용함으로써 `명확한 의미를 전달`해주기 때문에 코드의 가독성이 높다.
함수에서 직접 결과를 반환하기 때문에, `호출된 지점에서 바로 처리`가 가능하다.
그리고 map(), mapError(), flatMap(), flatMapError() 메소드를 지원하기 때문에 `추가적인 활용이 가능`하다는 특징이 있다.

*하지만*
Result 타입은 기존의 에러 처리를 완전히 대체하기 위해 사용되는 것은 아니다.
보다 에러 처리를 명확하게 하고, 코드를 간결하게 쓸 수 있도록 돕는 에러처리 방식 중 하나이다.

<br>

### 네트워킹 코드에서 Result 타입
- 네트워크 요청을 통해 데이터를 받아오는 코드를 통해 차이를 알아보자


**1. 튜플 타입을 활용한 데이터 전달**

```swift
// 튜플타입을 활용
func performRequest(with url: String, completion: @escaping (Data?, NetworkError?) -> Void) {
	guard let url = URL(string: url) else { return }
	
	URLSession.shared.dataTask(with: url) { (data, response, error) in
		// 에러 발생
		if error != nil {
			print(error!)                 // 에러가 발생했음을 출력
			completion(nil, .someError)   // 에러가 발생했으니, nil 전달
			return
		}
		// 옵셔널 바인딩 실패
		guard let safeData = data else {
			completion(nil, .someError)   // 안전하게 옵셔널 바인딩을 하지 못했으니, 데이터는 nil 전달
			return
			
		}
		// 성공
		completion(safeData, nil) // safe 데이터 전달
	}.resume()
}

performRequest(with: "주소") { data, error in
	// 데이터를 받아서 처리
	if error != nil {
		print(error!)
	}
	// 데이터 처리 관련 코드
}
```

- 에러나 옵셔널 바인딩에 대해 튜플에 nil을 넣어주고 있다. 이런 경우에는 코드를 잘못 작성할 경우 에러로 이어질 가능성이 있다.


**2. Result 타입을 이용한 데이터 전달**

```swift
// Result 타입 활용
func performRequest2(with urlString: String, completion: @escaping (Result<Data,NetworkError>) -> Void) {
	guard let url = URL(string: urlString) else { return }
	
	URLSession.shared.dataTask(with: url) { (data, response, error) in
		// 에러 발생
		if error != nil {
			print(error!)                     // 에러가 발생했음을 출력
			completion(.failure(.someError))  // 실패 케이스 전달
			return
		}
		// 옵셔널 바인딩 실패
		guard let safeData = data else {
			completion(.failure(.someError))   // 실패 케이스 전달
			return
		}
		// 성공
		completion(.success(safeData))      // 성공 케이스 전달
	}.resume()
}

performRequest2(with: "주소") { result in
	switch result {
	case .failure(let error):
		print(error)
	case .success(let data):
		// 데이터 처리 관련 코드
		break
	}
}
```

- 동일한 결과를 수행하나, 성공과 실패에 대한 명확한 구분을 할 수 있다.
- 함수가 결과를 직접 반환하기 때문에 콜백 함수를 통한 즉각적인 에러 처리가 가능하다.

<br>

## Result 타입의 활용

**get() 메서드**
- 결과값을 throwing 함수처럼 변환한다.

```swift
do {
	let data = try result.get()
	print("결과값은 \(data)입니다.")
} catch {
	print(error)
}
```