
//import Foundation
//
// 민재님이 주신 고차함수 뜯어보기
//extension Array {
//    func mapp<T>(_ transform: (Int) -> T) -> [T] {
//        var result: [T] = []
//        for num in self {
//            result.append(transform(num as! Int))
//        }
//        return result
//    }
//    
//    func reducee(_ initialResult: Int, _ nextPartialResult: (Int, Int) -> Int) -> Int {
//        var initialResult: Int = initialResult
//        self.forEach { element in
//            initialResult = nextPartialResult(initialResult, element as! Int)
//        }
//        return initialResult
//    }
//    
//    func filterr(_ isIncluded: (Int) -> Bool) -> [Int] {
//        var result: [Int] = []
//        for num in self {
//            if isIncluded(num as! Int) { result.append(num as! Int) }
//        }
//        return result
//    }
//    
//    func forEachh(_ body: (Int) -> Void) {
//        for num in self {
//            body(num as! Int)
//        }
//    }
//}
//var a = [1,2,3,4,5,6,7,8,9,10]
//print(a.mapp { String($0) + "번이다" })
//print(a.reducee(1, *))
//print(a.filterr { $0 % 2 == 0 })



// MARK: 맵, 필터, 리듀스 예제 1 -- 10/24
//func sumOfSquaresOfOdds(array: [Int]) -> Int {
//    array.filter{ $0 % 2 == 1 }.map{ $0 * $0 }.reduce(0, +)
////    array.filter{ $0 % 2 == 1}.reduce(into: 0){ $0 = $1 * $1 }
//}
//
//let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
//print(sumOfSquaresOfOdds(array: array))

//MARK: 맵, 필터, 리듀스 예제 2
//func reverseWithoutVowels(string: String) -> String {
//    String(string.filter{!"aeiouAEIOU".contains($0)}.uppercased().reversed())
//}
//
//let string = "Hello World"
//print(reverseWithoutVowels(string: string))

// MARK: 맵, 필터, 리듀스 예제 3
//func sumOfKeysWithEvenValues(dictionary: [String: Int]) -> Int{
////    dictionary.filter{ $0.1 % 2 == 0 }.map{ $0.1 }.reduce(0, +)    // value 값 더하기
//    dictionary.filter{ $0.1 % 2 == 0 }.map{Int(Character($0.0).asciiValue ?? 0)}.reduce(0, +)   // key의 아스키 코드 값 더하기
///* 또 다른 표현 방법. 그런데 Int로 반환 안 됨
//    reduce(0) { $0 + Character($1).asciiValue! }
//    reduce(0) { $0 + $1.unicodeScalars.first!.value }
//*/
//}
//
//let dictionary = ["a": 1, "b": 2, "c": 3, "d": 4, "e": 5]
//print(sumOfKeysWithEvenValues(dictionary: dictionary))

// MARK: 맵, 필터, 리듀스 예제 4
//func differenceBetweenMaxAndMin(array: [Int]) -> Int {
// 고차함수 없이 풀기
//    guard let max = array.max(), let min = array.min() else {return 0}
//    return max - min
////    let max = array.reduce(Int.min, max)
////    let min = array.reduce(Int.max, min)
////    return max - min
//}
//
//let array = [10, 20, 30, 40, 50]
//print(differenceBetweenMaxAndMin(array: array))

// MARK: 맵, 필터, 리듀스 예제 5
//func countElements(array: [String]) -> [String: Int] {
//    array.reduce(into: [:]){ $0[$1, default: 0] += 1 }
//}
//let array = ["a", "b", "a", "c", "b", "d"]
//print(countElements(array: array))

// MARK: 맵, 필터, 리듀스 예제 6
//func mostFrequentElement(array: [String]) -> String{
////  삽질
////    array
////        .reduce(into: [:]){ $0[$1, default: 0] += 1 }   // ["a":3, "b": 2]
////        .max{$0.value < $1.value}?    // (key: "a", value: 3)ㅌ
////        .key ?? "인선"
//    let counts = array.reduce(into: [:]) { $0[$1, default: 0] += 1}
//    let maxCount = counts.values.max()
//    return counts.filter{ $0.value == maxCount }.keys.randomElement()!
//}
//let array = ["a", "b", "a", "c", "b", "d"]
//print(mostFrequentElement(array: array))

// MARK: 맵, 필터, 리듀스 예제 7
//func addStars(array: [String]) -> [String] {
//    array.map{"*" + $0 + "*"}
//}
//let array = ["a", "b", "c"]
//print(addStars(array: array))

// MARK: 맵, 필터, 리듀스 예제 8
//func sumOfMultiplesOfThree(array: [Int]) -> Int {
//    array.filter{ $0 % 3 == 0 }.reduce(0, +)
//}
//let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
//print(sumOfMultiplesOfThree(array: array))

// MARK: 맵, 필터, 리듀스 예제 9
//func repeatTwice(array: [String]) -> [String] {
//    array.map{ $0 + $0 }    // ["aa", "bb", "cc"]
////    array.flatMap{ [$0, $0]}  // ["a", "a", "b", "b", "c", "c"] faltmap : 2차원 배열을 1차원 배열로 바꿔줌
//}
//let array = ["a", "b", "c"]
//print(repeatTwice(array: array))

// MARK: 맵, 필터, 리듀스 예제 10
//func lengthsOfElements(array: [String]) -> [Int] {
//    array.map{$0.count}
//}
//
//let array = ["apple", "banana", "cherry"]
//print(lengthsOfElements(array: array))

// MARK: 맵, 필터, 리듀스 예제 11 -- 10/25
// 주어진 문자열에서 모음(a, e, i, o, u)의 개수를 세는 함수를 작성하세요.
//func countVowels(_ word: String) -> Int{
//    let result = ["a", "e", "i", "o", "u"]
//    return result
//        .filter{ word.contains(String($0)) }
//        .count
//}
//let word = "swift"
//let voewlCount = countVowels(word)
//print(voewlCount)

// MARK: 맵, 필터, 리듀스 예제 12
// 주어진 문자열에서 각 알파벳이 몇 번 나오는지 세는 함수를 작성하세요.
//func countAlphabets(_ word: String) -> [Character : Int]{
//    word.filter{$0.isLetter}.reduce(into: [:]){ $0[$1, default: 0] += 1 }
//}
//let word = "Hello2World!!"
//let alphabetCount = countAlphabets(word)
//print(alphabetCount)  // ["e": 1, "o": 2, "r": 1, "H": 1, "W": 1, "d": 1, "l": 3]

// MARK: 맵, 필터, 리듀스 예제 13
// 주어진 문자열에서 각 단어의 첫 글자를 대문자로 바꾸는 함수를 작성하세요.
//func capitalize(_ sentence: String) -> String{
//    sentence
//        .split(separator: " ")
//        .map{$0.prefix(1).uppercased() + $0.suffix($0.count-1)} // preifx: 전달한 개수만큼 앞에서!, suffix: 전달한 개수만큼 뒤에서!
//        .joined(separator: " ")
///*  .capitalized: 첫 문자 대문자, 이후 문제 소문자로 변환
//    sentence
//        .split(separator: " ")
//        .map{ $0.capitalized}
//        .joined(separator: " ")
//*/
//}
//let sentence = "this is a test"
//let capitalizedSentence = capitalize(sentence)
//print(capitalizedSentence)      // "This Is A Test"

// MARK: 맵, 필터, 리듀스 예제 14
// 주어진 배열에서 각 요소를 역순으로 정렬하는 함수를 작성하세요. (컬렉션에서 제공하는 역순 함수 쓰지 않고 정렬)
//func reverse(_ numbers: [Int]) -> [Int]{
//    numbers.reduce([]){ [$1] + $0 }
//}
//let numbers = [1, 3, 4, 2, 5]
//let reversedNumbers = reverse(numbers)
//print(reversedNumbers)      // [5, 2, 4, 3, 1]

// MARK: 맵, 필터, 리듀스 예제 15
// 주어진 문자열에서 모든 소문자를 대문자로 바꾸는 함수를 작성하세요. (보너스 : 대문자는 소문자로 소문자는 대문자로 시도해 보세요.)
//func uppercase(_ word: String) -> String{
////    word.map{ $0.uppercased() }.joined()  // 소문자 대문자로 바꾸기
////    word.map{   // 대문자는 소문자로, 소문자는 대문자로 바꾸기
////        if $0.isLowercase { $0.uppercased() }
////        else{ $0.lowercased() }
////    }.joined()
//    word.map{ $0.isLowercase ? $0.uppercased() : $0.lowercased()}.joined()  // 삼항연산자로 작성
//}
//let word = "swiFt"
//let uppercasedWord = uppercase(word)
//print(uppercasedWord)       // "SWIFT"

// MARK: 맵, 필터, 리듀스 예제 16
// 주어진 문자열에서 모든 공백을 제거하는 함수를 작성하세요.
//func removeSpaces(_ sentence: String) -> String{
//    sentence.filter{ !$0.isWhitespace }
//}
//let sentence = "This is a test"
//let noSpaceSentence = removeSpaces(sentence)
//print(noSpaceSentence)      // "Thisisatest"
