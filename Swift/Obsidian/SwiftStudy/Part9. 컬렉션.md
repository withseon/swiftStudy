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
	분사형(ed/ing)인 경우: 해당 배열이 직접 변경 X. 변경된 (새로운) 배열 리턴

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
### 딕셔너리
	데이터를 키-값 하나의 쌍으로 만들어 관리하는 컬렉션
	순서 X

### 딕셔너리의 규칙
	[] 대괄호로 묶음
	'키(key)' 값은 유일해야 함
	동일한 데이터 타입 쌍만 가능
	'값(value)'에 딕셔너리 또는 배열을 사용해서 중첩 가능
		[String: [String]]
	
	'키(key)'값은 Hashable해야함

### *Hashable*
	해당 타입을 해시 함수의 input값으로 사용 가능하다는 의미
	Hashable 프로토콜 채택
	
	1. 값의 유일성 보장
	2. 검색 속도의 향상

Hash함수는 특정 input에 대해 항상 동일한 결과가 나옴
여기서 결과는 hash value

hash table
steve에 iphone을 대응시키는게 아니라, hash value에 iphone을 대응시키는 형식 (딕셔너리)
-> 배열에서 steve를 찾으려면 0부터 쭉 찾아야해서 시간이 오래걸림. 딕셔너리는 순서가 없잖아..? 그치만 빠르게 찾을 수 있지 해시테이블을 통해. 하나하나 검색해볼 필요가 없이, 해쉬 함수를 사용해서 스티브를 대응ㅇ시켜서 해쉬밸류를 찾아서 바로 해쉬 테이블에 있는 걸 찾아냄. 이게 해쉬테이블 알고리즘

### 딕셔너리 선언

```
// 정식 문법
var words: dictionary<Int, String>
// 단축 문법
// var words: [String: String]

// 타입을 선언하지 않고, 리터럴로 딕셔너리을 생성해서 저장 가능
var dic = ["A": "Apple", "B": "Banana", "C": "City"]

// 빈 딕셔너리 선언
let emptyDic1: Dictionary<Int, String> = [:]
let emptyDic2: Dictionary<Int, String>()
let emptyDic3 = [Int: String]()
```

### 딕셔너리 기본 기능

```
dic = ["A": "Apple", "B": "Banana", "C": "City"]

dic.count
dic.isEmpty

dic.contains(where: {})

dic.randomElement()
// (key: "A", vlaue: "Apple")
```

### 딕셔너리 접근
	서브스크립트[]를 이용한 문법을 주로 사용
	값만 따로 검색하는 방법은 제공 X

```
// 대괄호 안에 키(key)값을 넣어 사용
// 리턴 타입은 옵셔널 (존재하지 않는 키값에 접근하려고 했을 때 nil)
dic["A"]

// 참고
// 키 값이 "S"인 요소가 없으면, "Empty" 리턴. 리턴 타입 옵셔널 X
dic["S", default: "Empty"]
```

```
dic.keys // 전체 키
dic.values // 전체 값

// 전체 키(혹은 값)을 배열로 리턴
dic.keys.sorted()
dic.values.sorted()
```

### 딕셔너리 업데이트 (삽입 / 교체 / 추가)
	배열의 삽입과 추가는 특정 순서가 필요한데, 딕셔너리는 순서가 없음

```
var words: [String: String] = [:]

// 삽입(추가)
words["A"] = "Apple"
words["B"] = "Banana"

// 교체
words["B"] = "Blue"

// 정식 함수 문법 (update + insert = upsert). 리턴 타입 옵셔널
words.updateVlaue("Bean", forkey: "B") // 교체 시 기존 값(value) 리턴
words.updateValue("City", forkey: "C") // 새로운 요소가 추가되면 nil 리턴

// 딕셔너리 전체 교체
words = [:]
words = ["A": "A", "B", "B"]
```

### 딕셔너리 삭제 (remove)

```
dic = ["A": "Apple", "B": "Banana", "C": "City"]

dic["A"] = nil // 해당 요소 삭제
dic["E"] = nil // 아무 일이 일어나지 않음

// 정식 함수 문법. 리턴 타입 옵셔널
dic.removeValue(forKey: "A") // 삭제된 값(value) 리턴
dic.removeValue(forKey: "A") // nil 리턴

// 전체 삭제
dic.removeAll()
dic.removeAll(keepingCapacity: true) // 메모리 공간은 유지
```


## 딕셔너리 다루기
---
### 딕셔너리 비교
	딕셔너리는 순서가 없음. 순서 상관없이 비교

```
let a = ["A": "Apple", "B": "Banana", "C": "City"]
let b = ["A": "Apple", "C": "City", "B": "Banana"]

a == b // true
a != b // false
```

### 딕셔너리 활용

```
// 딕셔너리 중첩 사용
// 1. 값에 배열 넣기
var dic1 = [Stirng: [String]]()
dic1["arr1"] = ["A", "B", "C"]
dic2["arr2"] = ["D", "E", "F"]

// 2. 값에 딕셔너리 넣기
var dic2 = [String: [String: Int]]()
dic2["dic1"] = ["name": 1, "age": 3]
dic2["dic2"] = ["name": 2, "age": 4]
```

### 반복문과의 결합
	열거하지 않아도 _Named 튜플 형태_로 하나씩 꺼내서 전달
	딕셔너리는 순서가 없음. 반복문 순서는 실행할 때마다 달라짐

```
let dic = ["A": "Apple", "B": "Banana", "C": "City"]

for item in dic {
	print("\(item.0) - \(item.1)")
}

for (key, value) in dic {
	// key-value 바인딩해서 사용
}

for (_, vlaue) in dic {
	// vlaue만 바인딩해서 사용 (key는 와일드 카드 패턴)
}
```


## 집합(Set)
---
### Set-집합
	수학의 집합과 비슷한 연산을 제공하는 컬렉션
	순서 X
	정렬 순서보다 검색 속도가 중요한 경우에 사용
	합집합, 교집합, 차집합, 대칭차집합을 사용할 때 사용

### Set의 규칙
	[] 대괄호를 사용해서 묶음
	(배열과 동일하기 때문에, 타입을 꼭 명시해주어야 함)
	요소값을 중복으로 넣어도 중복 저장 불가
	요소는 Hashable

### Set 선언

```
// 정식 문법
var set: Set<Int>
// 단축 문법
var set: Set

// 리터럴로 선언 가능
let set: Set = [1, 2, 3]

// 빈 Set 생성
let emptySet: Set<Int> = []
let emptySet1 = Set<Int>()
```

## Set 기본 기능

```
set.count
set.isEmpty

set.contains()
set.randomElement()
```

### Set 업데이트 (삽입 / 교체 / 추가)
	배열의 삽입과 추가는 특정 순서가 필요한데, Set은 순서가 없음
	*Set은 서브스크립트 [] 문법이 없음*

```
// 정식 함수 문법
set.update(with: 1) // 중복 추가 불가. 기존 요소값 리턴
set.update(with: 7) // 새로운 요소 추가 시 nil 리턴
```

### Set 삭제 (remove)

```
var stringSet: Set<String> = ["Apple", "Banana", "City", "Swift"]

// 요소 삭제. 리턴 타입 옵셔널
stringSet.remove("Swift") // 삭제한 요소 리턴
stringSet.remove("iOS") // 없는 요소 삭제 시 에러 X. 리턴 nil

// 전체 삭제
stringSet.removeAll()
stringSet.removeAll(keepingCapacity: true) // 메모리 공간 유지
```

### Set의 활용

```
var a: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var b: Set = [1, 3, 5, 7, 9]
var c: Set = [2, 4, 6, 8, 10]
var d: Set = [1, 7, 5, 9, 3]
```

#### 1. Set의 비교

```
a == b // false
a != b // true

b == d // true
```

#### 2. 부분집합 / 상위집합 / 서로소

```
// 부분 집합 여부
b.isSubset(of: a) // true
b.isStrictSubset(of: a) // false. 진부분집합 여부
```

```
// 상위집합
a.isSuperset(of: b) // true
a.isStrictSuperset(of: b) // false. 진상위집합 여부
```

```
// 서로소
d.isdisjoint(with: c) // true
```

#### 3. 합집합

```
var unionSet = b.union(c)

// 원본 변경
// b.formUnion(c)
```

#### 4. 교집합

```
var interSet = a.intersection(b)

// 원본 변경
// a.formIntersection(b)
```
#### 5. 차집합

```
var subSet = a.subtracting(b)

// 원본 변경
// a.substract(b)
```

#### 6. 대칭차집합

```
var symmetricSet = a.symmetricDifference(b)

// 원본 변경
// a.formSymmetricDifference(b)
```

### 반복문과의 결합
	Set은 순서가 없음. 반복문 순서는 실행할 때마다 달라짐

```
for num in set {
}
```

### 기타 유의점
	sorted()를 사용하면, 요소가 정렬된 새로운 배열로 리턴가능

```
var newSet: Set = [1, 2, 3, 4, 5]
let newArray: Array = newSet.sorted()
```


## 스위프트 컬렉션 관리 이론
---
### Swift Naming Guide
	 동사 원형: 컬렉션 자체를 직접적으로 변환
	 분사(ed, ing): 컬렉션 자체를 직접 변환하지 않고, 리턴

### 배열과 Set
|        배열         |           Set            |
| :---------------: | :----------------------: |
|       순서 O        |           순서 X           |
| 실제 프로젝트에서 대부분의 경우 | 여러 데이터를 중복 저장할 필요가 없는 경우 |

### Swift 컬렉션
	구조체 (값 타입)
	let/var 로 불변/가변 여부 결정
	
	Array, Dictionary, Set + KeyValuePairs(Swift 5.2, 순서가 있는 딕셔너리)
	격체 형식/값 형식 모두 저장 가능
	하나의 컬렉션 안에 동일한 타입만 저장 가능

### Foundation 컬렉션
	클래스 (참조 타입)
	생성시에 불변/가변 여부 결정
	
	NSArray(NSMutableArray), NSDictionary(NSMutableDictionary), NSSet(NSMutableSet)
	객체 형식의 데이터만 저장 가능
	하나의 컬렉션 안에 동일한 타입만 저장할 필요 없음

### KeyValuePairs
	Swift 5.2 버전에 등장
	딕셔너리와 유사한 형태지만, 배열처럼 순서가 있음
	= key 값이 Hashable일 필요 X
	key 값 중복 가능


```
let introduce: KeyValuePairs = ["first": "Hello", "second": "My Name", "third": "is]
```

KeyValuePairs의 기본 기능
```
introduce.count
introduce.isEmpty
```

KeyValuePairs 요소 접근
```
introduce[0]
// (key: "first", value: "Hello")

introduce[0].1
/
// Hello
```

KeyValuePairs 특징

	순서가 있기 때문에 반복문을 순서대로 돌게 됨
	`append`와 `remove` 같은 기능이 없음
	딕셔너리지만, 저장된 순서가 중요한 경우 또는 데이터가 반복될 경우만 임시적/제한적 사용

### Copy-On-Write 최적화
	코드상에서 값을 복사해서 담는다고 하더라도, 
	실제 값이 바뀌기 전까지는 그냥 하나의 메모리 값을 공유해서 사용

```
var array = [1, 2, 3, 4, 5, 6, 7]

var subArray = array[0...2] // 이런 경우에 Copy-On-Write 최적화 발생
// subArray라는 새로운 메모리 공간을 만드는 게 아님
```

