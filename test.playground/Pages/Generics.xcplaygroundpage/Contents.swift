
import Foundation

// MARK: 제네릭 예제 1
// 다음 코드에서 컴파일 에러가 발생하는 이유를 설명하고, Generics을 사용하여 에러를 해결하는 방법을 제시하세요.
//struct Stack<T> {
//    var items = [T]()
//    mutating func push(_ item: T) {
//        items.append(item)
//    }
//    mutating func pop() -> T {
//        return items.removeLast()
//    }
//}
//
//var intStack = Stack<Int>()
//intStack.push(3)
//intStack.push(5)
//print(intStack.pop()) // 5
//
//var stringStack = Stack<String>()
//stringStack.push("Hello")
//stringStack.push("World")
//print(stringStack.pop())

// MARK: 제네릭 예제 2
// 제너릭 함수로 두 개의 값을 교환하는 swap 함수를 작성해보세요.
//func swap<T>(_ x: inout T, _ y: inout T) {
//    let tmp = x
//    x = y
//    y = tmp
//}
//
//
//var a = 10
//var b = 20
//swap(&a, &b)
//print(a, b) // 20, 10

// MARK: 제네릭 예제 3
// 제너릭 타입으로 스택을 구현해보세요.
// 스택은 push, pop, peek, isEmpty 등의 메서드를 가지고 있어야 합니다.
//struct Stack<T> {
//    var items: [T] = []
//    var isEmpty: Bool {
//        return items.count <= 0 ? true : false
//    }
//    mutating func push(_ n: T) {
//        items.append(n)
//    }
//    mutating func pop() -> T? {
//        return items.removeLast()
//    }
//    mutating func peek() -> T? {
//        return self.items.last
//    }
//}
//
//
//var stack = Stack<Int>()
//stack.push(1)
//stack.push(2)
//stack.push(3)
//print(stack.pop())   // 3
//print(stack.peek())  // 2
//print(stack.isEmpty) // false

// MARK: 제네릭 예제 4
// 제너릭 타입으로 큐를 구현해보세요.
// 큐는 enqueue, dequeue, front, isEmpty 등의 메서드를 가지고 있어야 합니다.

enum lastItemError: Error {
    case emptyError
}

//struct Queue<T> {
//    var items: [T] = []
//    var isEmpty: Bool {
//        items.count <= 0 ? true : false
//    }
//    mutating func enqueue(_ n: T) {
//        items.append(n)
//    }
//    mutating func dequeue() throws -> T {
//        if isEmpty {
//            throw lastItemError.emptyError
//        }
//        return items.removeFirst()
//    }
//    mutating func front() throws -> T {
//        if isEmpty {
//            throw lastItemError.emptyError
//        }
//        return items.first!
//    }
//}
//
//
//var queue = Queue<String>()
//queue.enqueue("A")
//queue.enqueue("B")
//queue.enqueue("C")
//print(queue.dequeue()) // A
//print(queue.front()) // B
//print(queue.isEmpty) // false

// MARK: 제네릭 예제 5
// 다음의 함수는 제네릭 타입 T를 인자로 받아서 T의 타입을 출력하는 함수입니다.
// 제네릭을 이용하여 함수를 완성하세요.
//func printType<T>(_ t: T) {
//    print("The type of \(t) is \(type(of: t))")   // T.self 사용해도 됨
//
//}
//
//printType(3) // The type of 3 is Int
//printType("Hello") // The type of Hello is String
//printType(true) // The type of true is Bool

// MARK: 제네릭 예제 6
// 다음의 클래스는 제네릭 타입 Key와 Value를 가지는 Node 클래스입니다.
// 제네릭을 이용하여 클래스를 완성하세요.
//class Node<T> {
//    var key: T
//    var value: T
//    
//    init(key: T, value: T) {
//        self.key = key
//        self.value = value
//    }
//}
//
//let node = Node(key: "name", value: "Alice")
//print(node.key) // name
//print(node.value) // Alice

// MARK: 제네릭 예제 7
// 다음의 함수는 두 개의 제네릭 타입 두 개의 인자를 받아서 두 값이 같은지 비교하는 함수입니다.
// 제네릭을 이용하여 함수를 완성하세요.
//func isEqual<T: Equatable>(_ x: T, _ y: T) -> Bool {
//    return x == y
//}
//
//print(isEqual(1, 1)) // true
//print(isEqual("Hello", "World")) // false
//print(isEqual(true, false)) // false

// MARK: 제네릭 예제 8
// 다음의 함수는 제네릭 타입 T를 인자로 받아서 T의 타입이 Int인지 확인하는 함수입니다.
// 제네릭을 이용하여 함수를 완성하세요.
//func isInt<T>(_ x: T) -> Bool {
//    return x is Int
//}
//
//print(isInt(3)) // true
//print(isInt("Hello")) // false
//print(isInt(true)) // false

// MARK: 제네릭 예제 9
// 다음의 함수는 제네릭 타입 T를 인자로 받아서 T의 타입을 Int로 캐스팅하는 함수입니다.
// 제네릭을 이용하여 함수를 완성하세요.
//func castToInt<T>(_ t: T) -> Int? {
//    return t as? Int
//}
//
//print(castToInt(3)) // 3
//print(castToInt("Hello")) // nil
//print(castToInt(true)) // nil

// MARK: 제네릭 예제 10
// 다음의 함수는 제네릭 타입 T를 가지는 배열을 인자로 받아서 배열의 첫 번째 원소와 마지막 원소를 교환하는 함수입니다.
// 제네릭을 이용하여 함수를 완성하세요.
//func swapFirstAndLast<T>(_ arr: inout [T]){
//    guard !arr.isEmpty else { return }
//    let first = arr[0]
//    arr[0] = arr[arr.count - 1]
//    arr[arr.count - 1] = first
//}
//
//var array = [1, 2, 3, 4, 5]
//swapFirstAndLast(&array)
//print(array) // [5, 2, 3, 4, 1]
//
//var array2 = ["A", "B", "C", "D"]
//swapFirstAndLast(&array2)
//print(array2) // ["D", "B", "C", "A"]

// MARK: 제네릭 예제 11
// 다음의 함수는 제네릭 타입 T를 가지는 배열을 인자로 받아서 배열의 모든 원소를 역순으로 출력하는 함수입니다.
// 제네릭을 이용하여 함수를 완성하세요.
//func printReverse<T: Sequence>(_ arr: T) {
//    for i in arr.reversed() {
//        print(i)
//    }
//    /**
//     for i in stride(frome: arr.count - 1, through: 0, by: -1) {
//        print(arr[i])
//     }
//     */
//}
//
//
//let array = [1, 2, 3, 4, 5]
//printReverse(array)
//let array2 = ["A", "B", "C", "D"]
//printReverse(array2)

// MARK: 제네릭 에제 12 - 이해못함
// 제너릭 타입으로 연결 리스트를 구현해보세요.
// 연결 리스트는 append, insert, remove, nodeAt 등의 메서드를 가지고 있어야 합니다.
class Node<T> {
    var value: T
    var next: Node?

    init(value: T) {
        self.value = value
    }
}

struct LinkedList<T> {
    private var head: Node<T>?

    mutating func append(_ value: T) {
        let newNode = Node(value: value)
        if head == nil {
            head = newNode
            return
        }

        var current = head
        while current?.next != nil {
            current = current?.next
        }
        current?.next = newNode
    }

    mutating func insert(_ value: T, at index: Int) {
        let newNode = Node(value: value)
        if index == 0 {
            newNode.next = head
            head = newNode
            return
        }

        var current = head
        var i = 0
        var previous: Node<T>?
        while current?.next != nil && i < index {
            previous = current
            current = current?.next
            i += 1
        }
        previous?.next = newNode
        newNode.next = current
    }

    mutating func remove(at index: Int) -> T? {
        if index == 0 {
            let value = head?.value
            head = head?.next
            return value
        }

        var current = head
        var i = 0
        var previous: Node<T>?
        while current?.next != nil && i < index {
            previous = current
            current = current?.next
            i += 1
        }
        previous?.next = current?.next
        return current?.value
    }

    func nodeAt(_ index: Int) -> Node<T>? {
        var current = head
        var i = 0
        while current?.next != nil && i < index {
            current = current?.next
            i += 1
        }
        return current
    }

}

// 예시 코드:
var list = LinkedList<Int>()
list.append(1)
list.append(2)
list.append(3)
list.insert(4, at: 1)
list.remove(at: 2)
print(list.nodeAt(0)?.value) // 1
print(list.nodeAt(1)?.value) // 4
print(list.nodeAt(2)?.value) // 3
