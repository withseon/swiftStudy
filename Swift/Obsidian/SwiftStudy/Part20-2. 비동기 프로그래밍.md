
**동기(Sync)와 비동기(Async)**
- 동기: 작업을 다른 쓰레드에 시킨 후, `끝나길 기다렸다가` 다음 작업을 진행
- 비동기: 작업을 다른 쓰레드에 시킨 후, `끝나는 걸 기다리지 않고` 다음 작업을 진행

**직렬(serial)과 동시(Concurrent)**
- 직렬: 분산처리 시킨 작업을 `다른 한 개의 쓰레드`에서 처리
- 동시: 분산처리 시킨 작업을 `다른 여러 개의 쓰레드`에서 처리

*직렬처리가 필요한 이유*
- *작업에 순서가 필요할 경우, 직렬 처리가 필요하다.*

*앱의 동작 과정*
- *앱을 시작하면 main()함수가 실행되고 앱 객체(UIApplicationMain)가 생성된다. 그 후 함수를 실행하면서 앱이 시작되고 `Main run loop`가 생성된다.*
- *`Main run loop`에서는 발생된 이벤트에 대한 처리를 담당한다.*
- *이는 무한 반복문으로 동작하며, 필요한 경우 `화면을 다시 그린다.` (이벤트 핸들링 + 화면 재구성)*
- *화면을 다시 그리는 건 `Main Thread(메인 쓰레드)`에서 이루어진다.*


---
# 동시성(Cuncurrency) 프로그래밍
`분산 처리 > 동시성 > 비동기 처리`
`성능/반응성/최적화의 문제를 해결`

네트워크 통신 시, 데이터를 요청하고 받는 과정에서 부하가 일어난다. (네트워크 작업이 화면 그리는 것보다 오래 걸리기 때문)
분산 처리를 함으로써 과부화 문제를 해결할 수 있다.

### iOS에서 동시성 처리 방법

메인 쓰레드에서 작업(Task)를 대기열(Queue, FIFO)에 보내면, 운영체제(iOS)가 여러 쓰레드로 분산처리 해준다.
- 작업은 큐에 들어오는 즉시, 쓰레드를 만들어서 배치한다.
- 오래 걸리는 작업이 다른 쓰레드에서 비동기적으로 동작할 수 있게 된다.
- 대기열 종류에는 `DispatchQueue`와 OperationQueue가 있다.

*물리적인 쓰레드와 소프트웨어적 쓰레드는 다르다.
물리적인 쓰레드 1개에 소프트웨어적 쓰레드(객체)가 여러 개 존재할 수 있다.
소프트웨어적 쓰레드(객체)는 작업 종료 후 반환된다. -> OS에서 관리*

**동시성(Concurrency)과 병렬(Parallel)**
- 동시성: 소프트웨어적 쓰레드(객체)에서 동시에 작업 처리
- 병렬: 물리적인 쓰레드에서 동시에 동작



## 동기와 비동기

**동기(Sync)**
- 작업을 다른 쓰레드에 시킨 후, `끝나길(결과를) 기다렸다가` 다음 작업을 진행
**비동기(Async)**
- 작업을 다른 쓰레드에 시킨 후, `끝나는 걸(결과를) 기다리지 않고` 다음 작업을 진행

*타 언어의 Blocking과 Non-Blocking (제어권 여부)*
- Blocking: CPU 제어권을 바로 반환하지 않음
- Non-Blocking: CPU 제어권 바로 반환
- Swift에서 동기는 Blocking, 비동기는 Non-Blocking 개념으로 사용

```swift
func task1() {
	print("Task 1 시작")
	sleep(2)
	print("Task 1 완료")
}

func task2() {
	print("Task 2 시작")
	sleep(2)
	print("Task 2 완료")
}

func task3() {
	print("Task 3 시작")
	sleep(2)
	print("Task 3 완료")
}

// 비동기 처리
// DispatchQueue는 비동기 처리를 위한 객체
// DispatchQueue.global() : 공통적으로 사용하는 Queue (동시)
print("Start")
DispatchQueue.global().async {
	task1()	  
}
DispatchQueue.global().async {
	task2()	  
}
DispatchQueue.global().async {
	task3()	  
}
print("End")
/*
Start
End -------------- "End"는 시작 이후에 프린트 될 수도 있다.
Task 2 시작
Task 1 시작
Task 3 시작
Task 1 완료
Task 3 완료
Task 2 완료
*/
```

```swift
// 전체가 하나의 작업
// 순서 보장 O
DispatchQueue.global().async {
	// 내부 동기적으로 처리
	print("Task1 시작")
	print("Task1-1")
	print("Task1-2")
	print("Task1 종료")
}

// 여러 작업으로 분산
// 순서 보장 X
DispatchQueue.global().async {
	print("Task2 시작")
}
DispatchQueue.global().async {
	print("Task2-1")
}
DispatchQueue.global().async {
	print("Task2-2")
}
DispatchQueue.global().async {
	print("Task2 종료")
}
```
- Task1은 하나의 DispatchQueue를 사용하여 비동기 처리하였다. 따라서 Task1 시작 ~ Task1 종료까지 내부에서는 동기적으로 처리되기 때문에 작업 순서가 보장된다.
- Task2sms 여러 개의 DispatchQueue를 사용하여 비동기 처리하였다. 따라서 Task2 시작 ~ Task2 종료까지 모두 분산 처리된 상태이며, 작업 순서를 보장할 수 없다.


## 직렬과 동시

**직렬(Serial)**
- 분산 처리 시킨 작업을 `하나의 쓰레드`에서 처리
- 순서가 중요한 작업을 처리할 때 사용
**동시(Concurrent)**
- 분산 처리 시킨 작업을 `여러 쓰레드`에서 처리
- 각각 독립적이지만 유사한 작업을 처리할 때 사용

```swift
// 직렬큐 생성
let serialQueue = DispatchQueue(label: "serial")

print("Start")
serialQueue.async {
	task1()
}
serialQueue.async {
	task2()
}
serialQueue.async {
	task3()
}
print("End")

/*
Start
End
Task 1 시작
Task 1 완료
Task 2 시작
Task 2 완료
Task 3 시작
Task 3 완료
*/
```


## 큐(Queue)의 종류

### DispatchQueue(GCD)
`GCD(Grand Central DispatchQueue)`

**(글로벌)메인큐**
`DipatchQueue.main`
- 메인쓰레드
- UI 업데이트가 이루어진다.
- Serial

```swift
let mainQueue = DispatchQueue.main
```


**글로벌큐**
`DispatchQueue.global(qos:)`
- QoS(우선순위) 설정 가능
- Concurrent

```swift
let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive) // QoS 설정
let defaultQueue = DispatchQueue.global() // 디폴트 글로벌큐
```


**프라이빗(Custom)큐**
`DispatchQueue(label: "...")`
- QoS(우선순위) 추론 및 설정 가능
- Serial(디폴트), Concurrent(Attribute로 설정 가능)

```swift
let privateQueue = DispatchQueue(label: "serial") // 직렬(기본값)
DispatchQueue(label: "custom", attributes: .concurrent) // 동시 설정
// DispatchQueue(label:, qos:, attributes:, autoreleaseFrequency:, target:)
```



*QoS(Quality of Service)*
- iOS가 QoS에 따라서 처리한다.
- 품질(우선순위)가 높을수록 다수의 쓰레드를 사용함으로써, 더 빨리 처리될 수 있도록 한다.

| QoS              |                                   상황                                   |  소요 시간  |
| :--------------- | :--------------------------------------------------------------------: | :-----: |
| .userInteractive |         유저와 직접적으로 상호작용하는 작업<br>(UI 업데이트 관련, 애니메이션, UI 반응 관련 등)         |  거의 즉시  |
| .userInitiated   |             유저가 즉시 필요하긴 하지만, 비동기적 처리된 작업<br>(로컬 데이터베이스 읽기)             |   몇초    |
| .default         |                                일반적인 작업                                 |    -    |
| .utility         | Progress Indicator와 함께 길게 실행되는 작업<br>(IO, Networking, 지속적인 데이터 feeds)  | 몇초 ~ 몇분 |
| .background      | 유저가 직접적으로 인지하지 않고 시간이 중요하지 않은 작업<br>(데이터 미리 가져오기, 유지보수, 서버 동기회 및 백업 등) |  몇분 이상  |
| .unspecified     |                  legacy API 지원<br>(쓰레드를 서비스 품질에서 제외)                   |    -    |

## GCD 사용 시 주의할 점

### 1. 반드시 메인큐에서 처리해야 하는 작업
`UI를 그리는 작업은 메인 쓰레드에서 이루어져야 한다.`

```swift
// 뷰의 UIImageView 객체
var imageView: UIImageView? = nil

let url = URL(string: "https://~")!

// URLSession은 내부적으로 비동기 처리된 함수
URLSession.shared.dataTask(with: url) { (data, response, error) in
	if let error = error {
		print("Error!")
	}
	
	guard let imageData = data else { return }
	
	// 데이터를 이미지로 변환
	let photoImage = UIImage(data: imageData)
	
	// imageView의 이미지를 바꿔줄 때(UI 변경 작업) 메인큐에서 동작하도록 함
	DispatchQueue.main.async {
		imageView?.image = photoImage
	}
}.resume()
```



### 2. 컴플리션 핸들러 ✨
- 비동기적 작업은 즉시 리턴이 이루어지기 때문에 `return이 아닌, 클로저를 호출하는 방식으로 설계해야 한다(콜백함수 사용).`

**Return을 하는 함수(잘못된 설계)**

```swift
func getImages(with urlString: String) -> UIImage? {
	let url = URL(string: urlString)!
	var photoImage: UIImage? = nil
	
	// URLSession은 비동기적으로 처리
	URLSession.shared.dataTask(with: url) { (data, response, error) in
		if error != nil {
			print("Error: \(error)")
		}
		guard let imageData = data else { return }
		let photoImage = UIImage(data: imageData)
	}.resume()
	
	return photoImage
}

getImages(with: "https://~") // nil 리턴됨
```

- URLSession은 비동기적으로 처리되기 때문에 data를 받아서 변환하여 저장하는 것보다 함수의 리턴이 먼저 이루어진다.
- 따라서 getImages의 리턴은 무조건 nil이 된다.
- 리턴에 `async` 키워드를 붙이는 방법이 있다. ✨


**콜백함수를 사용하는 함수(올바른 설계)**
- 비동기 함수의 작업이 완료된 후, 그 결과를 받아서 completionHandler를 실행하도록 한다.

```swift
func properlyGetImages(with urlString: String, completion: @escaping (UIImage?) -> Void) {
	let url = URL(string: urlString)!
	var photoImage: UIImage? = nil
	
	// URLSession은 비동기적으로 처리
	URLSession.shared.dataTask(with: url) { (data, response, error) in
		if error != nil {
			print("Error: \(error)")
		}
		guard let imageData = data else { return }
		let photoImage = UIImage(data: imageData)
		
		completion(photoImage)
	}.resume()
}

properlyGetImages(with: "https://~") { image in
	// 처리 관련 코드
	DispatchQueue.main.async {
		// UI 관련 작업
	}
}
```

- URLSession 내에서 completion 클로저를 호출함으로써, 비동기적 작업이 완료된 후 결과값을 가지고 completion 클로저를 실행하게 된다.



### OperationQueue
(내부적으로 GCD기반 구현)

- 메인큐 `OperationQueue.main`
- 프라이빗(Custom)큐 `OperationQueue()`

- QoS의 기본값은 .background지만, 기반하는 디스패치큐(unspecified 제외)의 QoS 영향을 받는다.
- Concurrent(디폴트), Concurrent(maxConcurrentOperationCount로 사용할 쓰레드 개수 설정 가능)

