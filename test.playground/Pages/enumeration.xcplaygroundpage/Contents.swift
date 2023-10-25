import Foundation

// MARK: 열거형 예제 2
//enum Animal{
//    case dog(name: String), cat(name: String), bird(name: String)
//}
//
//func checkAnimal(animals: [Animal]){
//    //animals.forEach
//    for animal in animals{
//        switch animal{
//        case Animal.dog(let name):
//            print("이 동물은 개이고 이름은 \(name)입니다.")
//        case Animal.cat(let name):
//            print("이 동물은 고양이이고 이름은 \(name)입니다.")
//        case Animal.bird(let name):
//            print("이 동물은 새이고 이름은 \(name)입니다.")
//        }
//    }
//}
//
//let animals = [Animal.dog(name: "바둑이"), Animal.cat(name: "나비"), Animal.bird(name: "짹짹이")]
//checkAnimal(animals: animals)

// MARK: 열거형 예제 3
//enum Season{
//    case spring, summer, autumn, winter
//}
//
//func getSeason(date: (month: Int, day: Int)) -> Season{
//    switch date.month{
//        case 3...5:
//            return .spring
//        case 6...8:
//            return .summer
//        case 9...11:
//            return .autumn
//        default:
//            return .winter
//    }
//}
//
//let today = (month: 10, day: 17)
//let season = getSeason(date: today)
//
//print("오늘은 \(season)입니다.")  // 오늘은 autumn입니다.
//print("오늘은 \( getSeason(date: (month: 6, day: 17)) )입니다.")      // 오늘은 summer입니다.
//print("오늘은 \( getSeason(date: (month: 12, day: 15)) )입니다.")     // 오늘은 winter입니다.
//print("오늘은 \( getSeason(date: (month: 3, day: 1)) )입니다.")       // 오늘은 spring입니다.

// MARK: 열거형 에제 4
//enum Calc{
//    case add, subtract, multiply, divide
//}
//func calculate(num1: Int, num2: Int, op: Calc) -> Int{
//    switch op{
//        case .add:
//            return num1 + num2
//        case .subtract:
//            return num1 - num2
//        case .multiply:
//            return num1 * num2
//        case .divide:
//            return num1 / num2
//    }
//}
//
//let result = calculate(num1: 10, num2: 5, op: .divide)
//
//print("결과는 \(result)입니다.")      //결과는 2입니다.
//print("결과는 \( calculate(num1: 10, num2: 5, op: .add) )입니다.")        //결과는 15입니다.
//print("결과는 \( calculate(num1: 10, num2: 5, op: .subtract) )입니다.")   //결과는 5입니다.
//print("결과는 \( calculate(num1: 10, num2: 5, op: .multiply) )입니다.")   //결과는 50입니다.

// MARK: 열거형 예제 6
//enum Direction{
//    case left, right, up, down
//}
//
//func move(position: (Int, Int), direction: Direction) -> (x: Int, y: Int){
//    switch direction{
//    case .right:
//        return (position.0 + 1, position.1)
//    case .left:
//        return (position.0 - 1, position.1)
//    case .up:
//        return (position.0, position.1 + 1)
//    case .down:
//        return (position.0, position.1 - 1)
//    }
//}
//
//let currentPosition = (x: 0, y: 0)
//
//var nextPosition = move(position: currentPosition, direction: .right)
//print("다음 위치는 (\(nextPosition.x), \(nextPosition.y))입니다.")
//
//nextPosition = move(position: currentPosition, direction: .left)
//print("다음 위치는 (\(nextPosition.x), \(nextPosition.y))입니다.")
//
//nextPosition = move(position: currentPosition, direction: .up)
//print("다음 위치는 (\(nextPosition.x), \(nextPosition.y))입니다.")
//
//nextPosition = move(position: currentPosition, direction: .down)
//print("다음 위치는 (\(nextPosition.x), \(nextPosition.y))입니다.")

// MARK: 열거형 예제 7
//// enum DiceSide: CaseIterable
//enum DiceSide{
//    case one, two, three, four, five, six
//}
//
//func rollDice() -> DiceSide{
//    let randomNum = Int.random(in: 1...6)
//    switch randomNum{
//    case 1:
//        return DiceSide.one
//    case 2:
//        return DiceSide.two
//    case 3:
//        return DiceSide.three
//    case 4:
//        return DiceSide.four
//    case 5:
//        return DiceSide.five
//    default:
//        return DiceSide.six
//    }
//    //return DiceSide.allCases.randomElement()!
//}
//
//let dice = rollDice()
//
//print("주사위의 면은 \(dice)입니다.")

// MARK: 열거형 예제 8
//enum Color{
//    case red(r: Int, g: Int, b: Int)
//    case green(r: Int, g: Int, b: Int)
//    case blue(r: Int, g: Int, b: Int)
//}
//
//func printColors(colors: [Color]){
//    for c in colors{
//        switch c{
//        case .red(let red, let green, let blue):
//            print("이 색상은 빨강이고 RGB 값은 \((red, green, blue))입니다.")
//        case .green(let red, let green, let blue):
//            print("이 색상은 초록이고 RGB 값은 \((red, green, blue))입니다.")
//        case .blue(let red, let green, let blue):
//            print("이 색상은 파랑이고 RGB 값은 \((red, green, blue))입니다.")
//        }
//    }
//}
//
//let colors = [Color.red(r: 255, g: 0, b: 0), Color.green(r: 0, g: 255, b: 0), Color.blue(r: 0, g: 0, b: 255)]
//printColors(colors: colors)
