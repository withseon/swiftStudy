## 반복문(for문)
---
i는 반복상수라고 함 (처음 알았음)
   
와일드 카드 패턴: (\_)
	생략의 의미

내림차순으로 변경해서 사용
```
for _ in (1...10).reversed() {
	//
}
```

배열 등 컬렉션 타입에서도 사용 가능
```
strArr = ["A", "B", "C"]

for str in strArr {
	print(str)
}
```

문자열에서도 사용 가능
```
for chr in "Hello" {
	print(chr, terminator: "")
}
```


홀수나 짝수만 뽑아낼 때 stride() 사용
from보다 to/through의 순이 더 크고 by가 음수일 수 있음!
### stride(from:, to:, by:)
```
for number in stride(from: 1, to: 15, by:2) {
	print(number)
}

// 결과값
// 1
// 3
// ..
// 13
```

### stride(from:, through:, by:)
```
for number in stride(from: 1, through: 15, by:2) {
	print(number)
}

// 결과값
// 1
// 3
// ..
// 15
```

### 반복 상수의 값을 변경하고 싶다면
내부에 variable 변수를 생성해서 반복 상수의 값을 할당
(근데 이런 경우 잘 없음)

### 중괄호의 의미 = 범위(Scope)
중괄호 내부에서 바깥에 있는 변수는 접근이 가능하나,
중괄호 외부에서 내부의 변수는 접근이 불가능하다.
`범위에 해당하지 않기 때문`

## for문 사용 시 주의점
---

```
// for문 바깥에 있는 변수와 반복상수의 이름이 같을 때
var name = "타코"

for name in 1...5 {
	print(name)
}
// 결과값
// 1
// 2
// ..
```
	영역에 가까운 변수가 출력된다.
	변수/상수의 이름이 겹치는 건 혼란을 야기하므로 지양하자.

여하튼
`반복문 내에서 정의된 변수/상수는 반복문 외부에서 못 씀`

## while문 / repeat-while문
---
### while문
```
while 조건문 {
	코드
}
```

	내부에 조건을 변화시킬 수 있는 코드가 있어야 함
	안하면 무한반복(루프)됨

### repeat-while문
```
var i = 1

repeat {
	print("\(3) * \(i) = \(3 * i)")
	i += 1
} while i <= 9
```

	먼저 한 번 실행하고, 조건을 판별해서 실행
	조건문이 마지막에 있음

|           for문           |         while문         |
| :----------------------: | :--------------------: |
| 반복 횟수를 알거나<br>컬렉션, 범위 이용 | 정해지지 않고<br>조건에 따라 바뀔 때 |
|   범위, 컬렉션, 문자열, stride   |           조건           |

## 반복문의 제어전송문(continue / break)
---
continue와 break를 통해 cpu에서 하는 제어를 다른 곳에 보낸다 -.
### continue
```
for num in 1...20 {
	if num % 2 == 0 {
		continue
	}
	print(num)
}

// 홀수만 출력됨
```

	continue를 만나면 다음 주기로 넘어감

### break
```
for num in 1...10 {
	if num == 6 {
		break
	}
	print(num)
}

// 5까지 출력됨
```

	 break를 만나면 반복문이 종료됨

### continue와 break는 중첩 for문에서 적용 범위를 유의해서 사용해야 함
	가장 인접한 반복문의 주기를 넘기거나 종료시킴

### Labeled Statements
	반복문을 중첩적으로 사용할 때, 각 반복문에 이름을 붙여서 가장 인접한 범위 이외의 반복문도 제어 가능
	일반적으로 대문자 사용

```
OUTER: for i in 0...2 {
	print("OUTER: \(i)")
	INNER: for j in 0...2 {
		if i >= 1 {
			print("    j:", j)
			continue OUTER
			// break OUTER
		}
		print(   "INNER: \(j)")
	}
}

// 결과
// OUTER: 0
//     INNER: 0
//     INNER: 1
//     INNER: 2
// OUTER: 1
//     j: 0
// OUTER: 2
//     j: 0
...
```