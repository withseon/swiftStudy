//import Foundation
//
//// 에러 핸들링 에제 1
//enum TemperatureError: Error{
//    case invalidTemperature
//}
//
//func celsiusToFahrenheit(_ temp: Float) throws -> Float{
//    guard temp >= -273.15 else {
//        throw TemperatureError.invalidTemperature
//    }
//    return temp * 1.8 + 32
//}
//func tempTrans(_ temp: Float) -> String{
//    
//    do {
//        let fahrenheit = try celsiusToFahrenheit(temp)
//        print(fahrenheit)
//    }catch TemperatureError.invalidTemperature {
//        print("Invalid temperature")
//    }catch{
//        print("Unknown error")
//    }
//    
//    return "Successful transfer"
//}
//
//tempTrans(-300)
//tempTrans(123)
//
//// 에러 핸들링 예제 2
//// 민재님 코드
////enum PasswordError: Error {
////    case tooShort, missingUppercase, missingLowercase, missingNumber, missingSymbol
////}
////
////func validatePassword(_ pwd: String) throws {
////    guard pwd.count >= 8 else { throw PasswordError.tooShort }
////    guard pwd.contains(where: { $0.isLowercase }) else { throw PasswordError.missingLowercase }
////    guard pwd.contains(where: { $0.isUppercase }) else { throw PasswordError.missingUppercase }
////    guard pwd.contains(where: { $0.isNumber }) else { throw PasswordError.missingNumber }
////    guard pwd.contains(where: { "!@#$%^&*()_+-=[]{}|;:,./<>?".contains($0) }) else { throw PasswordError.missingSymbol }
////}
////
////do {
//////    try validatePassword("abc123")
//////    try validatePassword("abc123sdff")
////    try validatePassword("abc123sdffE")
////} catch let error as PasswordError {
////    switch error {
////    case .tooShort:
////        print("Password is too short")
////    case .missingUppercase:
////        print("Password is missing an uppercase letter")
////    case .missingLowercase:
////        print("Password is missing a lowercase letter")
////    case .missingNumber:
////        print("Password is missing a number")
////    case .missingSymbol:
////        print("Password is missing a symbol")
////    }
////}
//
////창준님 코드 - 정규표현식
////enum PasswordError: Error {
////    case tooShort, missingUppercase, missingLowercase, missingNumber, missingSymbol
////}
////    
////func validatePassword(_ password: String) throws {
//////    let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\",.<>?])[A-Za-z\\d!@#$%^&*()_+\\-=\\[\\]{};':\",.<>?]{8,}$"
////
////    guard password.count >= 8 else { throw PasswordError.tooShort }
////    
////    guard password.range(of: "[A-Z]", options: .regularExpression) != nil else { throw PasswordError.missingUppercase }
////    
////    guard password.range(of: "[a-z]", options: .regularExpression) != nil else { throw PasswordError.missingLowercase }
////    
////    guard password.range(of: "\\d", options: .regularExpression) != nil else { throw PasswordError.missingNumber }
////    
////    guard password.range(of: "[!@#$%^&*()_+-=\\[\\]{}|;:,./<>?]", options: .regularExpression) != nil else { throw PasswordError.missingSymbol }
////    
////    print("Available Password")
////}
//
//enum PasswordError: Error{
//    case tooShort
//    case missingUppercase
//    case missingLowercase
//    case missingNumber
//    case missingSymbol
//}
//
//func validatePassword(_ pwd: String) throws -> Int{
//    let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
//    let lower = "abcdefghijklmnopqrstuvwxyz"
//    let number = "0123456789"
//    let symbols = "!@#$%^&*()_+-=[]{}|;:,./<>?"
//    var isUpper = false, isLower = false, isNumber = false, isSymbol = false
//    
//    for p in pwd{
//        if upper.contains(p){
//            isUpper = true
//        }else if lower.contains(p){
//            isLower = true
//        }else if number.contains(p){
//            isNumber = true
//        }else if symbols.contains(p){
//            isSymbol = true
//        }
//    }
//    guard pwd.count > 7 else{
//        throw PasswordError.tooShort
//    }
//    guard isUpper else{
//        throw PasswordError.missingUppercase
//    }
//    guard isLower else{
//        throw PasswordError.missingLowercase
//    }
//    guard isNumber else{
//        throw PasswordError.missingNumber
//    }
//    guard isSymbol else{
//        throw PasswordError.missingSymbol
//    }
//    return 0
//}
//
//func checkPWD(_ pwd: String){
//    do {
//        try validatePassword(pwd)
//    } catch let error as PasswordError {
//        switch error {
//        case .tooShort:
//            print("Password is too short")
//        case .missingUppercase:
//            print("Password is missing an uppercase letter")
//        case .missingLowercase:
//            print("Password is missing a lowercase letter")
//        case .missingNumber:
//            print("Password is missing a number")
//        case .missingSymbol:
//            print("Password is missing a symbol")
//        }
//    } catch{
//        print("Unkown error")
//    }
//}
//
//checkPWD("ASDB2d23")
//
//// 에러 핸들링 예제 3
//enum ATMError: Error{
//    case negativeAmount
//    case insufficientBalance
//}
//
//class ATM{
//    var balance: Double = 0
//    
//    func deposit(amount: Double) -> Bool{
//        if amount>0{
//            self.balance += amount
//            return true
//        }else{
//            return false
//        }
//    }
//    
//    func withdraw(amount: Double) throws -> Double{
//        guard amount >= 0 else{
//            throw ATMError.negativeAmount
//        }
//        guard amount < self.balance else{
//            throw ATMError.insufficientBalance
//        }
//        
//        self.balance -= amount
//        return amount
//    }
//}
//
//func usingATM(_ amount: Double){
//    
//    do {
//        let cash = try atm.withdraw(amount: amount)
//        print(cash)
//    } catch let error as ATMError {
//        switch error {
//        case .negativeAmount:
//            print("Cannot withdraw a negative amount")
//        case .insufficientBalance:
//            print("Cannot withdraw more than balance")
//        }
//    } catch {}
//    
//    print(atm.balance)
//}
//
//let atm = ATM()
//atm.deposit(amount: 1000)
//print(atm.balance)
//usingATM(500)
//
//// MARK: 에러 핸들링 예제 4
//enum CalculatorError: Error{
//    case DividionByZero
//}
//
//struct Calculator{
//    var result: Double = 0
//    func add(_ number: Double)
//    func substract(_ number: Double)
//    func multiply(_ number: Double)
//    func divide(_ number: Double)
//    
//    mutating func add(_ number: Double){
//        result += number
//    }
//    mutating func substract(_ number: Double){
//        result -= number
//    }
//    mutating func multiply(_ number: Double){
//        result *= number
//    }
//    mutating func divide(_ number: Double) throws -> {
//        if number != 0 {
//            throw CalculatorError.DividionByZero
//        }
//        result /= number
//    }
//}
//
//
