
import Foundation

// MARK: 옵셔널 체이닝 예제 1
// 옵셔널 체이닝을 이용하여 person의 name과 age를 출력
//struct Person {
//    var name: String?
//    var age: Int?
//}
//
//var person: Person? = Person(name: "Kim", age: 25)
//
//if let name = person?.name, let age = person?.age {
//    print(name, age)
//}else{
//    print("이름", "나이")
//}
//print((person?.name ?? ""))
//print((person?.age ?? 0))

// MARK: 옵셔널 체이닝 예제 2
// 옵셔널 체이닝을 이용하여 book의 title과 book.author의 name을 출력
//struct Author {
//    var name: String?
//}
//
//struct Book {
//    var title: String?
//    var author: Author?
//}
//
//var book: Book? = Book(title: "The Little Prince", author: Author(name: "Antoine de Saint-Exupéry"))
//
//if let ti = book?.title, let au = book?.author?.name {
//    print("\(ti), \(au)")
//}else{
//    print("NO 이름, 나이")
//}

// MARK: 옵셔널 체이닝 예제 3
// 옵셔널 체이닝을 이용하여 numbers 배열의 첫번째 원소에 10을 더한 값을 출력
//var numbers: [Int]? = [1, 2, 3]
//if let num = numbers?[0] {
//    print(num + 10)
//}
//print((numbers?[0] ?? 0) + 10)

// MARK: 옵셔널 체이닝 예제 4
// 옵셔널 체이닝을 이용하여 students 딕셔너리의 "Lee" 키에 해당하는 값에 1을 더한 값을 출력
var students: [String: Int]? = ["Kim": 90, "Lee": 80, "Park": 85]
if let score = students?["Lee"]{
    print(score + 1)
}

print((students?["Lee"] ?? 0) + 1)

// MARK: 옵셔널 체이닝 예제 5
// 옵셔널 체이닝을 이용하여 animal의 speak 메서드를 호출
//class Animal {
//    func speak() {
//        print("...")
//    }
//}
//
//class Dog: Animal {
//    override func speak() {
//        print("Woof")
//    }
//}
//
//var animal: Animal? = Dog()
//animal?.speak()

// MARK: 옵셔널 체이닝 예제 6
// 옵셔널 체이닝을 이용하여 matrix의 transpose 메서드를 호출하여 결과를 출력
struct Matrix {
    var elements: [[Int]]

    func transpose() -> Matrix {
        var result = [[Int]]()
        for i in 0..<elements[0].count {
            var row = [Int]()
            for j in 0..<elements.count {
                row.append(elements[j][i])
            }
            result.append(row)
        }
        return Matrix(elements: result)
    }
}

var matrix: Matrix? = Matrix(elements: [[1, 2, 3], [4, 5, 6]])
print(matrix?.transpose().elements ?? 0)

// MARK: 옵셔널 체이닝 예제 7
// MARK: 옵셔널 체이닝 예제 8
