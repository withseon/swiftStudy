
## 튜플
---
### 튜플(Tuple)
	여러 데이터를 한 곳에 묶음 (연관된 데이터)
	ex)
		좌표 - (Int, Int)
		사람 - (String, Int, String)

튜플 접근 방법
	변수.0
	변수.1
	변수.

### 이름이 메겨진 튜플(Named Tuple)

```
let human = (name: String, age: Int, address: String)

human.0 // name
human.1 // age
human.2 // address
```
	 코드의 가독성이 높아짐

### 튜플의 분해 
-  튜플의 요소를 각각 상수/변수화 가능(바인딩)
- `타입 앨리어스로도 쓸 수 있음`

```
let (a, b, c) = (5, 6, 7)

a // 5
b // 6
c // 7
```
	변수를 따로따로 어떤 이름을 사용해서 명확하게 사용하고 싶을 때, 분해하서 사용할 수 있음

### 튜플 값 비교
- 왼쪽 멤버부터 한번에 하나씩 비교하고 같을 경우 다음으로 넘어감
- 7개 요소 미만만 비교 가능
- `Bool 값은 비교 불가`. (참과 거짓은 크기를 비교할 수 없기 때문)


## 튜플의 활용
---
### 튜플과 switch문

```
// case문의 사용
switch human {
case ("타코", 27, "인천"):
	print("타코는 사람입니다.")
default:
	break
}
```

```
// 튜플과 switch문 바인딩
var coordinate = (9, 0)
switch coordinate {
case (let distance, 0), (0, let distance): // X축이나 Y축에 있으면
	print("X축 또는 Y축에 위치하며, \(distance)만큼의 거리가 떨어져있다.")
default:
	print("축 위에 있지 않다.")
}
```

```
// 튜플의 switch문 where절 활용
...
```

### 튜플을 사용하는 이유
	연관된 값들을 한번에 묶어 사용함으로써 이해하기 쉽고 편리함