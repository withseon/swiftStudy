## 스위프트 컬렉션
---
### 컬렉션
	데이터 바구니
	여러 개의 데이터를 한꺼번에 다루는 바구니 타입

#### Array(배열)
	데이터를 순서대로 저장하는 컬렉션
	서버에서 딕셔너리로 받아서 배열로 사용!

#### Dictionaray(딕셔너리)
	데이터를 키-값 하나의 쌍으로 만들어 관리하는 컬렉션
	순서가 없음
	서버와 통신하는 API는 대부분 딕셔너리 형태 

#### Set(세트)
	수학의 집합과 비슷한 연산을 제공하는 컬렉션
	순서가 없음

## 배열 (Array)
---
### 배열
	데이터를 순서대로 저장하는 컬렉션

### 배열의 규칙
	대괄호를 사용해서 묶음
	각각의 데이터 = 요소 (element)
	
	배열의 인덱스는 0부터 시작
	배열 내에는 동일한 타입만 가능
	순서가 존재. 값 중복 가능

### 배열 선언

```
// 정식 문법
let numsArray: Array<Int> = [1, 2, 3, 4, 5]
// 단축 문법
// let numsArray: [Int] = [1, 2, 3, 4, 5]

// 타입을 선언하지 않고, 리터럴로 배열을 생성해서 저장 가능
var stringArray = ["Apple", "Swift", "iOS", "Hello"]

// 빈 배열 선언 (타입을 명시해야 함)
let emptyArray1: [Int] = []
let emptyArray2 = Array<Int>() // 생성자
let emptyArray3 = [Int]()
```

### 배열의 기본 기능
	접근연산자를 이용하여 배열의 하위 기능을 사용해보는 예시

```
numsArray.count // 배열 요소의 개수
numsArray.isEmpty // 배열이 비어있는지 확인 (리턴은 Bool)

numsArray.contains(1) // 배열에 해당 아규먼트가 존재하는지 확인 (리턴은 Bool)

numsArray.randomElement() // 배열의 요소 중 랜덤으로 하나 추출

numsArray.swapt(0, 1) // 배열의 특정한 두 인덱스에 해당하는 요소를 바꿈
```

### 배열 요소 접근

1. 서브스크립트 문법

```
// [] 서브스크립트 문법 (대괄호를 이용한 특별한 함수)
stringArray[0] // "Apple"
stringArray[2] // "iOS"

stringArray[1] = "Steve" // 1번 인덱스의 요소 "Steve" 변경
```

2. 배열의 하위 기능을 사용하여 접근

```
stringArray.first // 리턴값 String? ==> 빈 배열이면 nil 리턴
stringArray.last
```

```
// 배열의 인덱스
stringArray.startIndex // 시작 인덱스
stringArray.endIndex // 
// stringArray.endIndex.advanced(by: -1)

stringArray.index(1, offsetBy: 2) // 1부터 2만큼 떨어진 인덱스

stringArray[stringArray.startIndex]
stringArray[stringArray.endIndex - 1]
// stringArray[stringArray.index(before: stringArray.endIndex)]

stringArray.firstIndex(of: "iOS") // 앞에서 부터 찾았을 때, "iOS"는 (앞에서부터) 몇번째
stringArray.lastIndex(of: "iOS") // 뒤에서 부터 찾았을 때, "iOS"는 (앞에서부터) 몇번째
```

#### *endIndex*
	마지막 요소의 인덱스가 아닌
	배열 메모리 공간의 끝 주소 !
	
	따라서, endIndex를 서브스크립트에 적용한다면 endIndex - 1로 접근해야 함

### 배열 요소 삽입 (insert)
	특정 인덱스의 위치에 삽입
	동일한 타입의 요소나, 동일한 타입 배열을 삽입할 수 있음

```
var alphabet = ["A", "B", "C", "D", E"]

alphabet.insert("F", at: 5) // 5번째 인덱스에 삽입
alphabet.insert(contentsOf: ["a", "b", "c"], at: 0) // 0번째 인덱스에 배열 삽입
```

### 배열 요소 교체 (replace)
	특정 인덱스나 범위의 요소를 교체, 삭제

```
alphabet = ["A", "B", "C", "D", E"]

// 특정 인덱스 요소 교체
alphabet[0] = "a"
// 특정 범위 요소 교체
alphabet[0...2] = ["x", "y", "z"]

// 교체 함수 문법
alphabet.replaceSubrange(0...2, with: ["a", "b", "c"])
```

```
// 특정 범위 요소 삭제
alphabet[0...1] = []
```

### 배열 요소 추가 (append)
	배열의 끝에 추가

```
alphabet = ["A", "B", "C", "D", E"]

// 연산자로 추가
alphabet += ["F"]

// 추가 함수 문법
alphabet.append("H")
alphabet.append(contentsOF: ["H", "I"])
```

### 배열 요소 삭제 (remove)

```
alphabet = ["A", "B", "C", "D", E"]

// 서브스크립트 문법으로 삭제
alphabet[0...2] = []

// 삭제 함수 문법
// 리턴 타입이 옵셔널이 아님. 빈 배열에 사용하면 에러 발생
alphabet.remove(at: 2) // 특정 인덱스의 요소 삭제 후 *삭제된 요소 리턴*
alphabet.removeSubrange(0...2) // 특정 범위의 요소 삭제
```

```
// 리턴 타입이 옵셔널이 아님. 빈 배열에 사용하면 에러 발생
alphabet.removeFirst() // 맨 앞 요소 삭제 후 *삭제된 요소 리턴*
alphabet.removeFirst(2) // 앞의 두개 요소 삭제 후 *리턴 안 함*

alphabet.removeLast()
alphabet.removeLast(2)

// 배열 요소 모두 삭제
alphabet.removeAll()
alphabet.removeAll(keepingCapacity: true) // 저장공간을 일단 보관 (내부 데이터만 일단 날림)
```

#### *removeAll(keepingCapacity:)*
	삭제 시, 메모리 공간을 남겨둠
	재할당을 할 때 빠르게 할당 가능


## 배열 기타 기능
---
```
var nums = [1, 2, 3, 1, 4, 5, 2, 6, 7, 4, 0]
```

### 배열 정렬
	동사 원형인 경우: 해당 배열이 직접 변경됨
	동사 과거형(ed)인 경우: 해당 배열이 직접 변경 X. 변경된 (새로운) 배열 리턴

```
// 배열 직접 정렬. 배열 리턴 X
nums.sort()
// 정렬된 새로운 배열을 리턴
nums.sorted()

// 배열 역순 정렬. 배열 리턴 X
nums.reverse()
// 정렬된 새로운 배열을 리턴
nums.reversed()

// 새로운 배열 생성 X. 배열 메모리는 공유하면서 역순으로 열거할 수 있는 형식 리턴
nums.sorted().reversed()
```

### 배열 랜덤 섞기

```
// 요소의 순서 랜덤으로 직접 바꾸기
nums.shuffle()
// 순서 랜덤으로 바뀐 배열을 리턴
nums.shuffled()
```

### 배열의 비교
```
let a = ["A", "B", "C"]
let b = ["a", "b", "c"]

a == b // false
a != b // true
```

### 배열 활용

```
// 특정 요소 한 개 삭제
var puppy1 = ["p", "u", "p", "p", "y"]

if let lastIndexOfP = puppy1.lastIndex(of: "p") {
	puppy1.remove(at: lastIndexOfP)
}
```

```
// 배열의 배열 접근
var data =[[1, 2, 3], [4, 5, 6], [7, 8]]
data[0][2] // 3
```

### 반복문과의 결합
	반복문에는 범위나 컬렉션 사용

```
for i in nums {
}
```

#### *enumerate*
	열거
	enumerated(): 열거된 것들을 Named 튜플 형태로 한개씩 전달

```
nums = [10, 11, 12, 13]

for tuple in nums.enumerated() {
	print(tuple)
	// 다음과 같은 형태로 튜플의 값에 접근할 수 있음
	// print("\(tuple.offset) - \(tuple.element)")
	// print("\(tuple.0) - \(tuple.1))
}

// 결과
// (offset: 0, element: 10)
// (offset: 1, element: 11)
// (offset: 2, element: 12)
// (offset: 3, element: 13)

for (index, word) in nums.enumertated() {
	print("\(index) - \(word)")
}

// 결과
// 0 - 10
// 1 - 11
// 2 - 12
// 3 - 13
```

## 딕셔너리 /해셔블
---

## 딕셔너리 다루기
---

## 집합(Set)
---

## 스위프트 컬렉션 관리 이론
---
