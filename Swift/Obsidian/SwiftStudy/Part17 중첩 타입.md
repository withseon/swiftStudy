`타입 내부에 타입을 선언`

```swift
class Aclass {
	struct Bstruct {
		enum Cenum {
			case aCase // 열거형 케이스 필요
			case bCase
			
			struct Dstruct {
			
			}
		}
		var name: Cenum
	}
}

let aClass: Aclass = Aclass()
let bStruct: Aclass.Bstruct = Aclass.Bstruct(name: .bCase) // 멤버와이즈 이니셜라이저
let cEnum: Aclass.Bstruct.cEnum = Aclass.Bstruct.Cenum.aCase // 열거형 케이스 선택
let dStruct: Aclass.Bstruct.cEnum.Dstruct = Aclass.Bstruct.Cenum.Dstruct()
```

### 중첩 타입 사용 이유

 > 특정한 타입 내에서만 사용할 수 있도록 한다.
 > 타입 관의 연관성을 구분하고, 내부 구조를 디테일하게 설계할 수 있다.
 


### *Swift 공식 문서 예제*

```swift
struct BlackjackCard {
	// 열거형 Suit (카드 모양)
	enum Suit: Character { // 원시값 사용
		case spades = "♠️", heart = "❤️", diamonds = "♦️", clubs = "♣️"
	}
	
	// 열거형 Rank (카드 숫자)
	enum Rank: Int { // 원시값 사용. 2부터 시작
		case two = 2, three, four, five, six, seven, eight, nine, tend
		case jack, queen, king, ace
		
		// 구조체 Values
		struct Values {
			let first: Int, second: Int?
		}
		
		// 계산 속성 (열거형 내부 저장 속성 선언 불가)
		// 열거형 값(순서)를 이용하여 Values 타입의 값 리턴
		var values: Values {
			// get 생략
			swift self { // Rank의 인스턴스 자신
			case .ace:
				return Values(first: 1, second: 11)
			case .jack, .queen, .king:
				return Values(first: 10, second: nil)
			default:
				return Values(first: self.rawValue, second: nil) // 원시값 이용
			}
		}
	}
	
	// 구조체 BlackjackCard 의 저장 속성
	// 구조체 내부에 선언한 열거형 타입을 사용
	let rank: Rank, suit: Suit
	
	// 구조체 BlackjackCard 의 계산 속성
	var description: String {
		// get 생략
		var output = "\(suit.rawValue) 세트, " // 원시값 이용
		output += "숫자 \(rank.values.first)" 
		if let second = rank.values.second { // 옵셔널 바인딩
			output += " 또는 \(second)"
		}
		return output
	}
}

// BlackjackCard(rank: BlackjackCard.Rank, suit: BlackjackCard.Suit)

// card1 = 스페이드 A
let card1 = BlackjackCard(rank: .ace, suit: .spades)
print("1번 카드: \(card1.description)")
// 1번 카드: ♠️ 세트, 숫자 1 또는 11

// card2 = 다이아몬드 5
let card2 = BlackjackCard(rank: .five, suit: .diamonds)
print("2번 카드: \(card2.description)")
// 2번 카드: ♦️ 세트, 숫자 5
```

- 외부에서 사용하기 위해서는 중첩되어 있는 타입도 붙여야 한다.

```swift
let heartsSymbol: Character = BlackjackCard.Suit.hearts.rawValue
let suit: BlackjackCard.Suit = BlackjackCard.Suit.hearts
let suit: BlackjackCard.Suit = .hearts
let suit = .hearts // ERROR! 타입 명시 해줘야 함
```



### *실제 API의 사용 예시*

```swift
// DateFormatter 인스턴스 생성
let fomatter: DateFormatter()

// formatter의 dateStyle 타입 확인
formatter.dateStyle = .full // 타입 추론 가능
// formatter.dateStyle = DateFormatter.Style.full (열거형)

/*
===============================================================
- var dateStyle: Style { get set }                   (타입 확인)
- var dateStyle: DateFormatter.Style { get set }     (내부 정의)
===============================================================
*/

// 타입 확인
let setting1: DateFormatter.Style = .full // 변수 타입 명시 시, 생략 가능
let setting2: DateFormatter.Style = DateFormatter.Style.medium
```

```swift
/* Style 열거형이 어디서 사용되는지 확인할 수 없음
enum Style {
	case full, long, medium, none
}
*/

struct DateFormatters {
	var style: Style
	
	// 중첩 타입으로, 타입관의 관계에 대해 명확하게 알 수 있음
	enum Style {
		case full, long, midum, none
	}
}
```


## 중첩 타입의 사용 예시들

1. 문자열 모음을 위해 사용

```swift
struct K {
	static let appName = "MySuperApp"
	static let cellIdentifier = "ReusableCell"
	
	struct BrandColors {
		static let purple = "BrandPurple"
		static let lightPurple = "BrandLightPurple"
	}
	
	struct FStore {
		static let collectionName = "message"
		static let senderField = "sender"
	}
}

let app = K.appName // "MySuperApp"
let color = K.BrandColor.lightPurple // "BrandLightPurple"
```

2. 메세지 모델 설계 (보낸 사람, 받는 사람, 내용, 시간)

```swift
class Message {
	// 외부에서 중첩타입 접근 불가
	private enum Status {
		case sent, received, read
	}
	
	// 저장 속성
	// 보낸 사람, 받는 사람
	let sender: String, recipient: String, content: String
	
	// 저장 속성
	// 보낸 시간
	let timeStamp: Date
	
	// 저장 속성
	// 메세지 상태 정보 (보냄/받음/읽음)
	private var status = Message.Status.sent
	
	init(sender: String, recipient: String, content: String) {
		self.sender = sender
		self.recipient = recipient
		self.content = content
		
		self.timeStamp = Date() // 현재 시간 생성
	}
	
	func getBasicInfo() -> String {
		return "보낸 사람: \(sender), 받는 사람: \(recipient), 메세지 내용: \(content), 보낸 시간: \(timeStamp.description), "
	}
	
	// 상태에 따라 색 변환
	func statusColor() -> UIColor {
		switch status {
		case .sent:
			return UIColor(red: 1, green: 0, blue: 0, alpha: 1)
		case .received:
			return UIColor(red: 1, green: 0, blue: 1, alpha: 1)
		case .read:
			return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
		}
	}
}

let message1 = Message(sender: "홍길동", recipient: "임꺽정", content: "뭐해?")
print(message1.getBasicInfo())

sleep(1)

let message1 = Message(sender: "임꺽정", recipient: "홍길동", content: "그냥있어")
print(message1.getBasicInfo())
```
