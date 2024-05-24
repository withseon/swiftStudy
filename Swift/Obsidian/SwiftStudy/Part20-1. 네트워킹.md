
## 네트워크 통신의 이해

HTTP(HyperText Transfer Protocol)
- 하이퍼 문서를 전송하는 것부터 시작하여 현재는 이미지, 영상, 음성, 파일, JSON 등 모든 형태의 데이터를 전송할 수 있다.
- 4계층 구조로 이루어져 있으며, App(애플리케이션), OS(트랜스포트, 인터넷), LAN(링크)를 통해 데이터를 전달한다.

HTTP 요청 메세지

```
POST /form/entry HTTP /1.1                           시작라인
---------------------------------------------------- 
Host. www.naver.com
Connetion: Keep-alive                                헤더 필드(header)
Content-Type: applicatioin/x-www-form-urlencoded
Content-Lenght: 10
---------------------------------------------------- 
                                                     공백라인
---------------------------------------------------- 
name=gildong&age=20                                  메세지 본문(message body)
---------------------------------------------------- 
```

HTTP 응답 메세지

```
HTTP /1.1 200 OK                                     시작 라인
----------------------------------------------------
Date: Tue, 10 Jul 2020 06:40:14 GMT
Content-Length: 352                                  헤더 필드(header)
Content-Type: text/html
----------------------------------------------------
                                                     공백 라인
---------------------------------------------------- 
<html>
...                                                  메세지 본문(message body)
----------------------------------------------------
```

- 시작라인
	- 요청 시: 메서드 + 요청대상(경로) + HTTP 버전
	- 응답 시: HTTP 버전 + 상태코드 + 문구(상태코드에 대한)
- 헤더: 모든 부가 정보 (HTTP 전송에 필요한 메타 데이터)
- 메세지: 실제 전송할 데이터 (JSON / HTML/ 이미지/ 영상 등)


### HTTP의 주요 메서드
|  메서드   |           설명           | HTTP 버전 |         사용 예시          |
| :----: | :--------------------: | :-----: | :--------------------: |
|  GET   |       리소스 취득(조회)       | 1.0 1.1 |       게시판 글 읽어오기       |
|  POST  |        엔티티(등록)         | 1.0 1.1 | 게시판 글쓰기/댓글달기/새로운 주문 생성 |
|  PUT   | 파일 전송(데이터 대체 / 없으면 생성) | 1.0 1.1 |   게시글 수정(데이터 전부 대체)    |
| PATCH  |       리소스 부분 변경        |   1.1   |  PUT에서 필요한 부분, 부분 변경   |
| DELETE |         파일 삭제          | 1.0 1.1 |         게시물 삭제         |

### HTTP의 주요 상태 코드

| 상태 코드 |            설명            |
| :---: | :----------------------: |
|  2xx  |        리퀘스트 정상 처리        |
|  4xx  | 서버가 리퀘스트 이해 불가(클라이언트 에러) |
|  5xx  |  서버가 리퀘스트 처리 실패(서버 에러)   |

### 쿼리 파라미터
- ?로 시작, &로 추가 가능
- 경로에 붙여서 사용할 수도 있고 message body에 넣어서 사용할 수도 있다. (GET의 경우, 주로 경로에 붙여서 사용)
- ex) ?q=swift&hl=ko

|  메서드  | 데이터 전송 방식 |     사용 예시     |
| :---: | :-------: | :-----------: |
|  GET  |  쿼리 파라미터  |  검색어 / 정렬 기준  |
| POST  |  메세지 바디   | 회원가입 / 게시글 작성 |
|  PUT  |  메세지 바디   |    게시글 수정     |
| PATCH |  메세지 바디   |    게시글 수정     |

### Response(응답) 데이터
- 앱에서 처리하는 데이터의 형태
- `JSON 형태`

```json
{
	"이름": "홍길동",
	"나이": 25
}
```


---
## REST API

`REST한 방식으로 API를 작성하자.`
- 명사형을 사용하여, 의미를 파악하기 쉽게 작성

참고 자료
- [REST API가 뭔가요? (얄팍한 코딩사전)](https://www.youtube.com/watch?v=iOueE9AXDQQ)
- [그런 REST API로 괜찮은가 (네이버 d2)](https://www.youtube.com/watch?v=RP_f5dMoHFc)

---


## iOS 데이터 요청의 4단계

1. URL(구조체)

```swift
let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBocOfficeList.json?key=오픈API키&targetDt=20240515"

let url = URL(string: movieURL)! // 강제 언래핑
```

2. URLSession
- session으로 일정 시간 동안 연결 상태 유지

```swift
let session = URLSession.shared // 싱글톤
// let session = URLSession(configuration: .default)
```

3. dataTask
- 일시정지 상태로 작업 부여

```swift
let task = session.dataTask(with: url) { data, response, error in // Data?, URLResponse?, Error?
	if error != nil {
		print(error?.localizedDescription)
		return
	}
	if let data = data {
		print(String(decoding: data, as: UTF8.self)) // 단순 출력
		// 데이터를 우리가 사용하려는 형태로 변형해서 사용
	}
}
```

4. 시작(resume)

```swift
task.resume()
```

```swift
URLSession.shared.dataTask(with: url) { data, response, error in
	// ...
}.resume()
```


### JSON 데이터 변환하기

- [JSON 데이터 Swift 코드 변환](https://app.quicktype.io/)
- `JSONDecoder` 및 `decode()` 메서드 사용
- Codable, Decodable, Encodable 프로토콜

```swift
// 서버에서 주는 형태
struct MovieData: Codable {
	let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
	let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct dailyBoxOfficeList: Codable {
	let rank: String
	let movieNm: String
	let audiCnt: String
	let audiAcc: String
	let openDt: String
}
```

```swift
func parseJSON(_ movieData: Data) -> [DailyBoxOfficeList]? {
	do {
		// Swift 5
		// 자동으로 원하는 클래스/구조체 형태로 분석
		let decoder = JSONDecoder()
		let decodedData = try decoder.decode(MovieData.self, from: movieData)
		return decodedData.boxOfficeResult.dailyBoxOfficeList
	} catch {
		return nil
	}
}
```

```swift
let task = session.dataTask(with: url) { data, response, error in // Data?, URLResponse?, Error?
	if error != nil {
		print(error?.localizedDescription)
		return
	}
	if let data = data {
		// 데이터를 우리가 사용하려는 형태로 변형해서 사용
		let movieList = parseJSON(data)
		dump(movieList) // print와 동일하지만, 데이터를 더 깔끔하게 볼 수 있음
	}
}
```


### 네트워크 통신 예시

```swift
// 커스텀
struct Movie {
	static var movieId: Int = 0
	let movieName: String
	let rank: Int
	let openDate: String
	let todayAudience: Int
	let totalAudience: Int

	init(movieNm: String, rank: String, openDate: String, audiCnt: String, accAudi: String) {
		self.movieName = movieNm
		self.rank = Int(rank)!
		self.openDate = openDate
		self.todayAudience = Int(audiCnt)!
		self.totalAudience = Int(accAudi)!
		Movie.movieId += 1
	}
}
```

```swift
// 서버와 통신

struct MovieDataManager {
	let movieURL = "http://~"
	let key = "000000"

	func fetchMovie(date: String, completion: @escaping ([Movie]?) -> Void) {
		let urlString = "\(movieURL)?key=\(key)&targetDt=\(date)"
		performRequest(with: urlString) { movies in
			completion(movies)
		}
	}

	func performRequest(with urlString: String, completion: @escaping ([Movie]?) -> Void) {
		// URL(구조체) 생성
		guard let url = URL(string: urlString) else { return }
		// session 생성
		let session = URLSession(configuration: .default)
		
		// session에 작업 부여 (비동기)
		let task = session.dataTask(with: url) { (data, response, error) in
			if error != nil {
				print(error!)
				completion(nil)
				return
			}
			
			guard let safeData = data else {
				completion(nil)
				return
			}
			
			// 데이터 분석
			if let movies = self.parseJSON(safeData) { // 클로저 내 강한 참조 'self'
				completion(movies)
			} else {
				completion(nil)
			}
		}
		// 작업 시작
		task.resume()
	}
	
	func parseJSON(_ movieData: Data) -> [Movie]? {
		// 함수 실행 확인 코드 (함수 이름 출력)
		print(#function)
		
		let decoder = JSONDecoder()
		
		do {
			let decodedData = try decoder.decode(MovieData.self, from: moiveData)
			let dailyLists = decodedData.boxOfficeResult.dailyBoxOfficeList
		
/*
			// 반복문으로 movie 배열 생성
			var myMovieLists = [Movie]()
			
			for movie in dailyLists {
				let name = movie.movieNm
				let rank = movie.rank
				let openDate = movie.openDt
				let todayAudi = movie.audiCnt
				let accAudi = movie.audiAcc
				
				let myMovie = Movie(moiveNm: name, rank: rank, openDate: openDate, audiCnt: todayAudi, accAudi: accAudi)
				
				myMovieLists.append(myMovie)
			}
*/
			// 고차함수 이용
			let movieLists = dailyLists.map { Movie(moiveNm: name, rank: rank, openDate: openDate, audiCnt: todayAudi, accAudi: accAudi) }
			
			return movieLists
		} catch {
			print("parsing fail")
			return nil
		}
	}
}
```

```swift
// 뷰컨트롤

var downloadedMovies = [Movie]()
// 데이터 다운로드 및 분석/변환 구조체
let movieManager = MovieManager()

// 다운로드
movieManager.fetchMovie(date: "20240515") { (movies) in
	if let movies = movies {
		downloadedMovies = movies
		dump(downloadedMovies)
		
		print("전체 영화 개수: \(Movie.movieId)")
	} else {
		print("download fail")
	}
}
```
