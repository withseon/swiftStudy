//
//import Foundation
//
//// MARK: 액터 예제 2
//actor Multiplier{
//    var factor = 0
//    
//    init(factor: Int = 0) {
//        self.factor = factor
//    }
//    
//    func multiply(_ num: Int) -> Int{
//        return self.factor * num
//    }
//}
//
//let multiplier = Multiplier(factor: 2)
//Task{
//    let result = await multiplier.multiply(4)
//    print(result)
//}
//
//// MARK: 액터 예제 3
//actor Counter{
//    var count = 0
//    
//    func increment(){
//        self.count += 1
//    }
//}
//
//let counter = Counter()
//Task{
//    await counter.increment()
//    let result = await counter.count
//    print(result)
//}
//
//// MARK: 액터 예제 4
//actor Concatenator{
//    func concatenate(_ str1: String, _ str2: String) -> String{
//        return str1 + str2
//    }
//}
//let concatenator = Concatenator()
//async {
//    let result = await concatenator.concatenate("Hello", "World")
//    print(result) // 출력 결과: HelloWorld
//}
//
//// MARK: 액터 예제 5
//actor StringEx{
//    var str = ""
//    
//    init(_ str: String = "") {
//        self.str = str
//    }
//    
//    func capitalize() -> String{
//        return str.uppercased()
//    }
//    
//    func lowercase() -> String{
//        return str.lowercased()
//    }
//    
//    func reverse() -> String{
//        return String(str.reversed())
//    }
//}
//
//let str = StringEx("swIFt")
//Task{
//    print(await str.capitalize())
//    print(await str.lowercase())
//    print(await str.reverse())
//}
//
//// MARK: 액터 예제 6
//enum BankError: Error{
//    case negativeAmount
//    case insufficientBalance
//}
//
//
//actor BankAccount{
//    var balance: Double = 0
//    
//    func deposit(_ amount: Double) -> Bool{
//        if amount > 0{
//            self.balance + amount
//            return true
//        }else{
//            return false
//        }
//    }
//    
//    func withdraw(_ amount: Double) throws -> Double{
//        if amount < 0{
//            // err
//            throw BankError.negativeAmount
//        }
//        if amount > balance{
//            // err
//            throw BankError.insufficientBalance
//        }
//        self.balance -= amount
//        return amount
//    }
//}
//
//let account = BankAccount()
//Task{
//    await account.deposit(2000)
//    try? await account.withdraw(500)
//    print(await account.balance)
//    
//}
//Task{
//    await account.deposit(3000)
//    try? await account.withdraw(6000)
//    print(await account.balance)
//}
