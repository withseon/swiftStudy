import Foundation

// MARK: 상속 예제 5
//class Animal{
//    var name: String = ""
//    var sound: String = ""
//
//    init(name: String){
//        self.name = name
//        print(name)
//    }
//
//    func makeSound(){}
//}
//
//class Cat: Animal{
//
//    override init(name: String) {
//        super.init(name: name)
//    }
//    override func makeSound() {
//        self.sound = "야옹"
//        print(sound)
//    }
//}
//
//class Dog: Animal{
//    override init(name: String) {
//        super.init(name: name)
//    }
//    override func makeSound() {
//        self.sound = "멍멍"
//        print(sound)
//    }
//}
//
//let cat: Animal = Cat(name: "나비")
//let dog: Animal = Dog(name: "바둑")
//cat.makeSound()
//dog.makeSound()

// MARK: 상속 예제 6
//class Person{
//    var name: String = ""
//    var age: Int = 0
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//
//    func introduce(){
//        print("저는 \(name)이고, \(age)살입니다.")
//    }
//}
//
//class Student: Person{
//    var grade: Int = 0
//    var classNumber: Int = 0
//
//    init(name: String, age: Int, grade: Int, classNumber: Int) {
//        self.grade = grade
//        self.classNumber = classNumber
//        super.init(name: name, age: age)
//    }
//
//    override func introduce() {
//        print("저는 \(name)이고, \(age)살입니다. 저는 \(grade)학년 \(classNumber)반입니다.")
//    }
//
//}
//
//class Teacher: Person{
//    var subject: String = ""
//
//    init(name: String, age: Int, subject: String) {
//        self.subject = subject
//        super.init(name: name, age: age)
//    }
//
//    override func introduce() {
//        print("저는 \(name)이고, \(age)살입니다. 저는 \(subject)선생님입니다.")
//    }
//}
//
//let student: Person = Student(name: "민수", age: 15, grade: 2, classNumber: 3)
//let teacher: Person = Teacher(name: "영희", age: 25, subject: "수학")
//student.introduce()
//teacher.introduce()


// MARK: 상속 예제 7
//class Shapes{
//    var color: String = ""
//
//    init(color: String) {
//        self.color = color
//    }
//
//    func area() -> Double{ return 0}
//}
//
//class Triangle: Shapes{
//    var base: Double = 0
//    var height: Double = 0
//
//    init(color: String, base: Double, height: Double) {
//        self.base = base
//        self.height = height
//        super.init(color: color)
//    }
//
//    override func area() -> Double{
//        return self.base * self.height * 1/2
//    }
//}
//
//class Rectangle: Shapes{
//    var width: Double = 0
//    var length: Double = 0
//
//    init(color: String, width: Double, length: Double) {
//        self.width = width
//        self.length = length
//        super.init(color: color)
//    }
//
//    override func area() -> Double{
//        return self.width * self.length
//    }
//}
//
//let triangle = Triangle(color: "red", base: 3, height: 4)
//let rectangle = Rectangle(color: "blue", width: 5, length: 6)
//print(triangle.area())
//print(rectangle.area())

// 상속 예제 11 - X 오버로딩은 같은..! 오버라이딩은 상속..!
// 상속 예제 12 - X
// 상속 예제 13 - O

// MARK: 상속 예제 14
//class Vehicle{
//    var model: String = ""
//    var color: String = ""
//
//    init(model: String, color: String) {
//        self.model = model
//        self.color = color
//    }
//
//    func drive() -> String{ return "\(model) \(color)" }
//}
//
//class Car: Vehicle{
//    var doorNumber: Int = 0
//
//    init(model: String, color: String, doorNumber: Int) {
//        self.doorNumber = doorNumber
//        super.init(model: model, color: color)
//    }
//
//    override func drive() -> String {
//        return "\(model) \(color) 자동차가 \(doorNumber)개의 문을 열고 달립니다."
//    }
//}
//
//class Motorcycle: Vehicle{
//    var helmet: Bool = false
//
//    init(model: String, color: String, helmet: Bool) {
//        self.helmet = helmet
//        super.init(model: model, color: color)
//    }
//
//    override func drive() -> String {
//        return "\(model) \(color) 오토바이가 헬멧을 \(helmet ? "쓰고" : "안 쓰고") 달립니다."
//    }
//}
//
//let car: Vehicle = Car(model: "소나타", color: "검정", doorNumber: 4)
//let motorcycle: Vehicle = Motorcycle(model: "니노", color: "노랑", helmet: true)
//car.drive()
//motorcycle.drive()

// MARK: 상속 예제 15
//class Food{
//    var name: String = ""
//    var price: Int = 0
//
//    init(name: String, price: Int) {
//        self.name = name
//        self.price = price
//    }
//
//    func order() -> String{
//        return ""
//    }
//}
//
//class Pizza: Food{
//    var topping = ""
//
//    init(name: String, price: Int, topping: String) {
//        self.topping = topping
//        super.init(name: name, price: price)
//    }
//
//    override func order() -> String {
//        return "\(name) 피자에 \(topping)토핑을 주문하였습니다. 가격은 \(price)원입니다."
//    }
//}
//
//class Pasta: Food{
//    var sauce = ""
//
//    init(name: String, price: Int, sauce: String) {
//        self.sauce = sauce
//        super.init(name: name, price: price)
//    }
//
//    override func order() -> String {
//        return "\(name) 파스타에 \(sauce) 소스를 선택하였습니다. 가격은 \(price)원입니다."
//    }
//}
//
//let cheesePizza: Food = Pizza(name: "치즈", price: 15000, topping: "치즈")
//let carbonara: Food = Pasta(name: "카르보나라", price: 12000, sauce: "크림")
//cheesePizza.order()
//carbonara.order()

// MARK: 상속 예제 16
//class Animal{
//    var name: String = ""
//    var age: Int = 0
//    var bark: String = ""
//
//    init(name: String, age: Int, bark: String) {
//        self.name = name
//        self.age = age
//        self.bark = bark
//    }
//
//    func cry() -> String{
//        return "\(name)이(가) \(bark)라고 짖어요"
//    }
//}
//
//class Cat: Animal{
//
//    init(name: String, age: Int, meow: String) {
//        super.init(name: name, age: age, bark: meow)
//    }
//
//    override func cry() -> String{
//        return "\(name)이(가) \(bark)하고 울어요."
//    }
//}
//
//class Dog: Animal{
//}
//
//class Duck: Animal{
//}
//
//let kitty = Cat(name: "나비", age: 3, meow: "야옹")
//let puppy = Dog(name: "초코", age: 2, bark: "멍멍")
//let duck = Duck(name: "멋쟁", age: 2, bark: "꽥꽥")
//
//let animals: [Animal] = [kitty, puppy, duck]
//for ani in animals { print(ani.cry()) }
