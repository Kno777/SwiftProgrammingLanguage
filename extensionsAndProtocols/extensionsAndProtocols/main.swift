
// MARK: - Extensions

/*
 Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you don’t have access to the original source code (known as retroactive modeling). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions don’t have names.)
 
 Extensions in Swift can:
 
 Add computed instance properties and computed type properties Define instance methods and type methods
 
 Provide new initializers
 
 Define subscripts
 
 Define and use new nested types
 
 Make an existing type conform to a protocol
 
 In Swift, you can even extend a protocol to provide implementations of its requirements or add additional functionality that conforming types can take advantage of. For more details, see Protocol Extensions.
 
 NOTE:
 Extensions can add new functionality to a type, but they can’t override existing functionality.
 */



//extension SomeType{}

/*
 An extension can extend an existing type to make it adopt one or more protocols. To add protocol conformance, you write the protocol names the same way as you write them for a class or structure:
*/
//extension SomeType: SomeProtocol, AnotherProtocol {}

import Foundation

extension Double{
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.0.km
//print("One inchis \(oneInch) meters")

/*
 NOTE:
 Extensions can add new computed properties, but they can’t add stored properties, or add property observers to existing properties.
*/


// MARK: - Methods
/*
 Extensions can add new instance methods and type methods to existing types. The following example adds a new instance method called repetitions to the Int type:
*/

extension Int {
    func repetition(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    
    func print(){
        Swift.print(self)
    }
}


//3.repetition {
//    print("Hello")
//}

//5.print()


// MARK: - Mutating Instance Methods

/*
 Instance methods added with an extension can also modify (or mutate) the instance itself. Structure and enumeration methods that modify self or its properties must mark the instance method as mutating, just like mutating methods from an original implementation.
 
 The example below adds a new mutating method called square to Swift’s Int type, which squares the original value:
*/

extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 5
someInt.square()
//someInt.print()


// MARK: - Subscripts

/*
 Extensions can add new subscripts to an existing type. This example adds an integer subscript to Swift’s built-in Int type. This subscript [n] returns the decimal digit n places in from the right of the number:
 
  123456789[0] returns 9
  123456789[1] returns 8
*/

extension Int {
    subscript(digitIndex: Int) -> Int {
        var base = 1
        for _ in 0..<digitIndex {
            base *= 10
        }
        return (self / base) % 10
    }
}

//print(123[2])


// MARK: -  Nested Types

/*
 Extensions can add new nested types to existing classes, structures, and enumerations:
*/


extension Int {
    enum Kind {
        case negative, zero, positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

print(4.kind)


func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ",terminator: "")
        case .zero:
            print("0 ",terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([12,0,-45, 0, -45, 99])


class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Person {
    static var count = 0
    
    convenience init() {
        self.init(name: "", age: 1)
        Person.count += 1
    }
    
    func PersonCreatedCount() -> Int {
        return Person.count
    }
}



//let person = Person()
//let x = Person()
//print(person.PersonCreatedCount())
//print(x.PersonCreatedCount())


// MARK: - Protocols

/*
 A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.
 
 In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.
*/


protocol SomeProtocol{
 
}

struct SomeStructure: SomeProtocol {
    
}

/*
 Property Requirements
 A protocol can require any conforming type to provide an instance property or type property with a particular name and type. The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type. The protocol also specifies whether each property must be gettable or gettable and settable.
 
 If a protocol requires a property to be gettable and settable, that property requirement can’t be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it’s valid for the property to be also settable if this is useful for your own code.
 
 Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }.
*/

protocol AnotherProtocol{
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol FullyNamed{
    var fullName: String { get }
    func printName() -> Void
}

struct Humen: FullyNamed {
    var fullName: String
    func printName() {
        print(self.fullName)
    }
}

let human = Humen(fullName: "Kno")
human.printName()

protocol Togglable{
    mutating func toggle()
}


enum OnOffSwitch: Togglable{
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()


// MARK: - Initializer Requirements

/*
 Protocols can require specific initializers to be implemented by conforming types. You write these initializers as part of the protocol’s definition in exactly the same way as for normal initializers, but without curly braces or an initializer body:
*/

protocol SomeProtocolInit {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol{
    init(someParameter: Int) {
        print("ddd")
    }
}

let k = SomeClass(someParameter: 34)


// MARK: - Failable Initializer Requirements

/*
 Protocols can define failable initializer requirements for conforming types, as defined in Failable Initializers.
 A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.
*/

protocol FailableInit {
    init?()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

protocol DiceGame{
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate:AnyObject{
     func gameDidStart(_ game: DiceGame)
     func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
     func gameDidEnd(_ game: DiceGame)
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

class Dice{
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator:
         RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1;
    }
}

var d6=Dice(sides:6,generator: LinearCongruentialGenerator())

print(d6.roll())


// MARK: - Adding Protocol Conformance with an Extension

/*
 You can extend an existing type to adopt and conform to a new protocol, even if you don’t have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand. For more about extensions, see Extensions.
*/

protocol ForInt {
    func isPositive() -> Bool
}

extension Int: ForInt {
    func isPositive() -> Bool {
        if self > 0 {
            return true
        }
        return false
    }
}

var x = -33
print(x.isPositive())


// MARK: - Protocol Inheritance

/*
 A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits. The syntax for protocol inheritance is similar to the syntax for class inheritance, but with the option to list multiple inherited protocols, separated by commas:
*/


protocol SayHello {
    func sayHello() -> Void
}

protocol SayBye {
    func sayBye() -> ()
}

protocol HelloAndBye: SayHello, SayBye {
    func helloAndBye()
}

struct Hola: HelloAndBye {
    func helloAndBye() {
        print("helloAndBye")
    }
    
    func sayHello() {
        print("sayHello")
    }
    
    func sayBye() {
        print("sayBye")
    }
    
    func callAll() {
        helloAndBye()
        sayHello()
        sayBye()
    }
}

//Hola().callAll()


// MARK: - Protocol Composition

/*
 It can be useful to require a type to conform to multiple protocols at the same time. You can combine multiple protocols into a single requirement with a protocol composition. Protocol compositions behave as if you defined a temporary local protocol that has the combined requirements of all protocols in the composition. Protocol compositions don’t define any new protocol types.
 
 Protocol compositions have the form SomeProtocol & AnotherProtocol. You can list as many protocols as you need, separating them with ampersands (&). In addition to its list of protocols, a protocol composition can also contain one class type, which you can use to specify a required superclass.
 
 Here’s an example that combines two protocols called Named and Aged into a single protocol composition requirement on a function parameter:
*/

protocol Named{
    var name: String { get }
}

protocol Aged{
    var age: Int { get }
}

struct Man: Named,Aged{
    var name: String
    var age: Int
}


func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthday = Man(name: "Kno", age: 20)

wishHappyBirthday(to: birthday)

