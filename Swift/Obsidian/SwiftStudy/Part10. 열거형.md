
## 열거형의 기본 개념
---
### Custom Type
	마음대로 만들어서 쓸 수 있는 타입
	Enum(열거형), Class(클래스), Struct(구조체)

### 열거형(Enumeration)
	타입 자체를 한정된 사례(case) 안에서 정의할 수 있는 `타입`
	코드의 가독성과 안정성이 높아짐
	명확한 분기 처리 가능

#### 열거형 선언

```
// 타입 이름은 대문자, 케이스는 소문자로 시작
enum Weekday {
	case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

// 컴마(,) 없음
enum CompassPoint {
	case north
	case south
	case east
	case west
}
```

#### 열거형 사용

```
var today = Weekday.monday
today = .sunday // 타입을 명시해줬을 경우 사용
```

#### 열거형과 Switch문
	분기처리가 쉬움

```
switch CompassPoint {
case .north:
	//
case .south:
	//
case .east:
	//
case .west:
	//
}
```


## 열거형의 원시값과 연관값
---
### 원시값(Raw Values)
	매칭되는 기본값을 정의하여 열거형을 더 쉽게 사용 가능하게 함
	Hashable한 타입으로 원시값 정의
	원시값을 명시하지 않으면 자동으로 저장 (Int인 경우 0, 1, 2, String인 경우 case 명)

```
// 원시값 정의
// 다음 경우에는 자동으로 0, 5, 6으로 원시값 저장
enum Alignment: Int {
	case left
	case center = 5 // 원시값 명시
	case right
}

var align = Alignment(rawValue: 0) // Alignment.left. 옵셔널 리턴

let leftValue = Alignment.center.rawValue // 접근연산자를 통해 원시값 접근 가능
```

#### 원시값의 활용

```
enum RpsGame: Int {
	case rock, paper, scissors
}

RpsGame(rawValue: 0) // 옵셔널 리턴
RpsGame(rawValue: 1)
RpsGame(rawValue: 2)

// 랜덤값을 가위바위보로
let number = Int.random(in: 0...100) % 3
print(RpsGame(rawvValue: number)!) // 0~2 로 나오니까 강제추출
```


### 연관값(Associated Values)
	`구체적인 추가 정보`를 저장하기 위해 사용
	각 케이스별로 상이한 특징이 있고, 그것을 저장/활용하기 위해 사용
	
	튜플의 형태이며 자료형 제한이 없음
	하나의 케이스에 서로 다른 연관값 저장 가능 (열거형 값 생성 시 저장)
	
	`연관값을 사용할 때, case는 카테고리`라고 생각하면 편함! 연관값은 카테고리 내 각기 다른 정보정도..?

```
enum Computer {
	case cpu(core: Int, ghz: Double)
	case ram(Int, String)
	case hardDisk(gb: Int)
}

let myChip1 = Computer.cpu(core: 8, ghz: 3.5)
let myChip2 = computer.cpu(core: 4, ghz: 2.0)
```

### *원시값과 연관값의 차이*
|             원시값              |              연관값               |
| :--------------------------: | :----------------------------: |
| Hashable한 타입(주로 Int, String) |        튜플 형태. 타입 제한 없음         |
|         선언 시점에 값 저장          | 새로운 열거형 값 생성 시(= 인스턴스 생성 시) 저장 |
	**원시값과 연관값은 같이 사용할 수 없음**

#### 연관값의 활용

```
var chip = Computer.cpu(core: 8, ghz: 3.1)

switch chip {
case .cpu(core: 8, ghz: 3.1):
	//
case .cpu(core: 8, ghz: 2.6):
	//
default:
	//
}

// 연관값을 가진 케이스 매칭
switch chip {
case .cpu(let a, let b):
	// a와 b 바인딩하여 사용
case let .ram(a, _):
	// case .ram(let a, _)과 동일!
case .hardDisk(let a):
	//
}
```



## 옵셔널 타입에 대한 정확한 이해
---

	옵셔널(Optional) 타입
		메모리에 값이 없을 때 접근하게 되면 에러가 발생. 에러가 발생하지 않도록 임시적인 타입(Enum)을 담아두는 개념
	옵셔널(Optional) 타입의 내부는 열거형, 열거형의 연관값으로 값이 저장

옵셔널 타입의 내부 구현

```
enum Optional<Wrapped> { // 제네릭 문법
	case some(Wrapped) // 연관값
	case none
}
```

```
var num: Int? = 7

Optional.some(7)
Optional.none

enum Optional {
	case some(Int)
	case none
}

// 열거형 case 패턴을 활용해서 내부 연관값을 꺼냄
switch num {
case .some(let a):
	print(a)
case .none: // case nil: 과 동일!!
	print("nil")
}
```

> .none은 명시적인 열거형으로 표현한 것. .none과 nil은 동일하다 !

## 열거형과 Switch문의 활용
---

	열거형은 주로 Switch문과 사용
	열거형은 `한정된 사례(case)`로 구성되었기 때문에 Switch 분기처리에 최적화

```
enum LoginProvider {
	case email, apple, google
}

let userLogin = LoginProvider.apple

switch userLogin {
case .email:
	//
case .apple:
	//
case .google:
	//
}

if LoginProvider.email == userLogin {
	//
}
```


### 열거형에 `연관값이 없고`, `옵셔널 열거형`의 경우

```
enum SomeEnum {
	case left
	case right
}

// 타입을 다시 옵셔널 열거형으로 선언
let x: SomeEnum? = .left
```

	SomeEnum?은 옵셔널열거형이다. 그런데, 옵셔널 자체도 열거형이기 때문에
	SomeEnum은 열거형 내부에 열거형을 갖는 형태로 구현되어 있다.
	
	값이 있는 경우 .some 은 내부에 다시 열거형으로 .left / .right
	값이 없는 경우 .none으로 nil

```
// 원칙
switch x {
case .some(let value):
	switch value {
	case .left:
		//
	case .right:
		//
	}
case .none :
	//
}

// 편의적 기능 제공
switch x {
case .some(.left):
	//
case .some(.right):
	//
case .none:
	//
}
```

### switch문의 편의성
	switch문에서 옵셔널 열거형 타입을 사용할 때, 벗기지 않아도(.some 사용 x) 내부값 접근 가능

```
switch x {
case .left:
	//
case .right:
	//
case nil:
	//
}
```


## 열거형에 연관값이 있는 경우
---
### switch문에서의 사용

	연관값을 변수에 바인딩하여 사용 가능
		case Enum.case(let 변수명):
		case let Enum.case(변수명):

### if / guard / for-in / while문에서의 사용

#### if문
	특정 케이스만 다루기 위해 사용

```
if case Computer.hardDisk(gb: let gB) = chip { // let gB는 연관값
	print("\(gB)기가 바이트 하드디스크")
}
```

#### for문
	열거형 타입 배열을 반복문에 사용
	특정 케이스만 다루기 위해 사용

```
let chiplists: [Computer] = [
	.cup(core: 4, ghz: 3.0)
	.cup(core: 8, ghz: 3.5)
	.ram(16, "SRAM")
]

for case let .cpu(core: c, ghz: h) in chiplists { // .cpu인 경우만 뽑아서 반복
	print("\(c)코어, \(h)헤르츠 CPU")
}
```

옵셔널 타입을 포함하는 배열에서 반복문 사용
```
let arrays: [Int?] = [nil, 2, 3, nil, 5]

for case let .some(number) in arrays { // for case .some(let number)와 동일
	print("Found a \(number)")
}
```


## 옵셔널 패턴
---

	옵셔널 타입에서 열거형 케이스 패턴을 더 간소화한 `옵셔널 패턴`
	열거형 패턴:
		case .some(let x)
	옵셔널 패턴:
		case let x?

```
// 열거형 케이스 패턴
switch a {
case .some(let z):
	print(z)
case .none: // case nil과 동일
	print("nil")
}
```

```
// 옵셔널 패턴
switch a {
case let z?: // .some을 간소화. let z? = Optional.some(a)
	print(z)
case nil:
	print("nil")
}
```

switch문 뿐만 아니라 if문과 for문에도 사용 가능

```
// if문 열거형 케이스 패턴
if case .some(let x) = a {
	print(x)
}

// if문 옵셔널 패턴
if case let x? = a {
	print(x)
}
```

```
let arrays: [Int?] = [nil, 2, 3, nil, 5]

// for문 열거형 케이스 패턴
for case .some(let number) in arrays {
	print(number)
}

// for문 옵셔널 패턴
for case let number? in arrays {
	print(number)
}
```



## 열거형의 @unknown 키워드 (Swift 5.0 이후)
---

	열거형의 사례(case)가 늘어날 수 있는 경우, switch문 또한 수정해주어야 안정성을 유지하는데
	이때, switch문에 `@unknown default:`를 사용하게 되면 해당 열거형의 사례(case)가 추가되었을 때
	'Switch must be exhaustive'라는 노란색 에러가 뜨게 된다.
	에러는 switch문에 새로 추가한 사례(case)에 대한 case문을 작성하면 사라진다.
	
	@unknown 키워드를 사용하면 열거형 케이스 추가 시 해당 열거형에 대한 switch문을 발견하기 쉬워진다!