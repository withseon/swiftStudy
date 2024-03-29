// 비동기(동시성)
//import Foundation

//// 동시성 예제 3
//func asyncFunction() async -> Int{
//    let random = Int.random(in: 1...30)
//    return random
//}
//
//Task{
//    async let result = asyncFunction()
//    await print(result)
//}

//// 동시성 예제 4
//func asyncAdd(_ x: Int, _ y: Int) async -> Int{
//    return x + y
//}
//
//func asyncPrintsum(_ a: Int, _ b: Int) async {
//    let sum = await asyncAdd(a, b)
//    print(sum)
//}
//
//Task{
//    await asyncPrintsum(10, 11)
//}

//// 동시성 예제 5
//func fetchUser(id: Int) async -> String{
//    // some network request
//    return "User \(id)"
//}
//
//func printUser(id: Int) async{
//    let user = await fetchUser(id: id)
//    print(user)
//}
//
//Task{
//    await printUser(id: 1234)
//}

//// 동시성 예제 6
//func asyncDouble(_ x: Int) async -> Int{
//    return x * 2
//}
//
//func syncDouble(_ x: Int){
//    Task{
//        print(await asyncDouble(x))
//    }
//}
//
//syncDouble(10)

//// 동시성 예제 7
//func asyncAdd(_ x: Int, _ y: Int) async -> Int {
//    return x + y
//}
//
//func asyncPrintSum() async{
//    let a = await asyncAdd(10, 20)
//    let b = await asyncAdd(30, 40)
//    print(a + b)
//}
//
//Task{
//    await asyncPrintSum()
//}
