//
//import Foundation
//
//// MARK: 딕셔너리 예제 1 -- 10/23
//// 못품
////func mostFrequentValue(dict: [String: Int]) -> Int {
////    var result = [
////    for (k, v) in dict{
////        if
////    }
////    return 0
////}
////
////let dict1 = ["a": 1, "b": 2, "c": 3, "d": 2, "e": 2]
////mostFrequentValue(dict: dict1)  // 2
//
//// MARK: 딕셔너리 예제 2
////func reverseKeyValue(dict: [String: String]) -> [String: String] {
////    var result = [String: String]()
////    for (k, v) in dict{
////        result[v] = k
////    }
////    return result
////}
////
////let dict2 = ["apple": "red", "banana": "yellow", "grape": "purple"]
////let result = reverseKeyValue(dict: dict2)
////print(result)
//
//// MARK: 딕셔너리 예제 3
////func keysWithValue(dict: [String: Int], value: Int) -> [String] {
////    var result = [String]()
////    for (key, value) in dict{
////        if value == 2{
////            result.append(key)
////        }
////    }
////    return result
////}
////
////let dict3 = ["a": 1, "b": 2, "c": 3, "d": 2, "e": 1]
////let result = keysWithValue(dict: dict3, value: 2)
////print(result)
//
//// MARK: 딕셔너리 예제 4
////func dictToString(dict: [String: Any]) -> String {
////    var result = ""
////    for (key, value) in dict{
////        result += "\(key) : \(value),"
////    }
////    result.removeLast()
////    return result
////}
////
////let dict4: [String: Any] = ["name": "Alice", "age": 20, "gender": "female"]
////let result = dictToString(dict: dict4)
////print(result)
//
//// MARK: 딕셔너리 예제 5
////func sumOfKeysAndValues(dict: [Int: Int]) -> (Int, Int) {
////    var keySum = 0
////    var valueSum = 0
////    for (k, v) in dict{
////        keySum += k
////        valueSum += v
////    }
////    return (keySum, valueSum)
////}
////
////let dict5 = [1: 10, 2: 20, 3: 30]
////let result = sumOfKeysAndValues(dict: dict5)
////print(result)
//
//// MARK: 딕셔너리 예제 6
////let person: [String: Any] = ["name": "Kim", "age": 25, "job": "programmer"]
////print(person["name"] ?? "")
//
//// MARK: 딕셔너리 예제 7
////let fruit = ["apple": 3, "banana": 5, "orange": 2]
////for (k, v) in fruit{
////    print(k, v)
////}
//
//// MARK: 딕셔너리 예제 8 -- 10/24
////let scores = ["math": 90, "english": 85, "science": 95]
////scores.values.max()
//
//// MARK: 딕셔너리 예제 9
////let colors = ["red": "#FF0000", "green": "#00FF00", "blue": "#0000FF"]
////var reversedColors = [String:String]()
////colors.forEach {
////    reversedColors[$0.1] = $0.0
////}
////print(reversedColors)
//
//// MARK: 딕셔너리 예제 10
////let dict1 = ["a": 1, "b": 2, "c": 3]
////let dict2 = ["b": 2, "c": 4, "d": 5]
////dict1.forEach {
////    if dict2[$0.0] == $0.1{
////        print("\($0.0):\($0.1)")
////    }
////}
//
//
//// MARK: 딕셔너리 예제 11
////var even = ["a": 2, "b": 3, "c": 4, "d": 5]
////print(even.filter{$0.1 % 2 != 0})
//
//
//// MARK: 딕셔너리 예제 12
////let countries = ["KR": "South Korea", "US": "United States", "JP": "Japan", "CN": "China"]
////print(countries.sorted { $0.0 < $1.0 })
////print(countries.keys.sorted())
//
//
//// --------------------------------------------------------------------------------------
//
//// MARK: 집합 예제 1 -- 10/23
////func intersect(_ set1: Set<Int>, _ set2: Set<Int>) -> Set<Int>{
////    return set1.intersection(set2)
////}
////let setA: Set<Int> = [1, 2, 3, 4, 5]
////let setB: Set<Int> = [3, 4, 5, 6, 7]
////let intersection = intersect(setA, setB)
////print(intersection) // [3, 4, 5]
//
//// MARK: 집합 에제 2
////func unite(_ set1: Set<String>, _ set2: Set<String>) -> Set<String>{
////    return set1.union(set2)
////}
////let setC: Set<String> = ["apple", "banana", "cherry"]
////let setD: Set<String> = ["cherry", "durian", "elderberry"]
////let union = unite(setC, setD)
////print(union) // ["apple", "banana", "cherry", "durian", "elderberry"]
//
//// MARK: 집합 예제 3
////func subtract(_ set1: Set<Double>, _ set2: Set<Double>) -> Set<Double>{
////    return set1.subtracting(set2)
////}
////let setE: Set<Double> = [1.0, 2.0, 3.0, 4.0, 5.0]
////let setF: Set<Double> = [2.0, 4.0, 6.0]
////let difference = subtract(setE, setF)
////print(difference) // [1.0, 3.0, 5.0]
//
//// MARK: 집합 예제 4
////func disjoint(_ set1: Set<Character>, _ set2: Set<Character>) -> Bool{
////    return set1.isDisjoint(with: set2)
////}
////let setG: Set<Character> = ["a", "b", "c"]
////let setH: Set<Character> = ["d", "e", "f"]
////let isDisjoint = disjoint(setG, setH)
////print(isDisjoint) // true
//
//// MARK: 집합 예제 5
//func getSubsets(_ set: Set<Int>) -> [[Int]] {
//    let array:[Int] = Array(set)
//    var result: [[Int]] = []
//    let n = array.count
//
//    print((1 << n))
//    for i in 0..<(1 << n) {
//        var subset = [Int]()
//        for j in 0..<n {
//            if i & (1 << j) != 0 {
//                subset.append(array[j])
//                print(i, j, i & (1 << j), array[j] )
//            } else {
//                print(i, j, i & (1 << j) )
//            }
//        }
//        print()
//        result.append(subset)
//    }
//
//    return result
//}
//let setI: Set<Int> = [1, 2, 3]
//let subsets = getSubsets(setI)
//print(subsets) // [[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]]
//               // 또는 [Set([]), Set([2]), Set([1]), Set([1, 2]), Set([3]), Set([3, 2]), Set([1, 3]), Set([3, 2, 1])]
