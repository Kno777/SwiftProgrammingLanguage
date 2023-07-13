
import Foundation

//func future(closure: @escaping (Int) -> Void) {
//    DispatchQueue.main.asyncAfter(deadline: .now()) {
//        closure(3)
//    }
//}
//
//future(closure: { int in
//    print(int)
//})

//var car = "Mers"
//
//var closure = {
//    print(car)
//}
//
//closure()
//
//car = "bmw"
//
//closure()

//
//class Stutend {
//    var name = 0
//}
//
//struct Stutend2 {
//    var name = 0
//}
//
//let x = Stutend()
//var y = Stutend2()
//
//x.name = 909
//y.name = 88


struct Person2 {
    var name: String
    let surname: String
}

var person1 = Person2(name: "Davo", surname: "ddd")
person1.name = "Hakob" // ok
// person1.surname = "gg" // error

let person2 = Person2(name: "Hovo", surname: "fff")
// person2.name = "Kno" // error

/*
 👆
 This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.
 
 The same isn’t true for classes, which are reference types. If you assign an instance of a reference type to a constant, you can still change that instance’s variable properties.
*/

// MARK: - Lazy Stored Properties

/*
 A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used. You indicate a lazy stored property by writing the lazy modifier before its declaration.
*/

/*
 NOTE:
 You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore can’t be declared as lazy.
*/

class DataImporter{
    
    /*
    DataImporter is a class to import data from an
     external file.
    The class is assumed to take a nontrivial amount
     of time to initialize.
     */
    
    var filename = "data.txt"
    
    // the DataImporter class would provide data importing functionality here
}

class DataManager{
    
    lazy var importer = DataImporter()
    
    var data: [String] = []
    
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

/*
 Because it’s marked with the lazy modifier, the DataImporter instance for the importer property is only created when the importer property is first accessed, such as when its filename property is queried:
 */

print(manager.importer.filename)
//the DataImporter instance for the importer property has now been created

struct DataImporter2{
    
    /*
    DataImporter is a class to import data from an
     external file.
    The class is assumed to take a nontrivial amount
     of time to initialize.
     */
    
    var filename = "data.txt"
    
    // the DataImporter class would provide data importing functionality here
}

struct DataManager2{
    
    lazy var importer = DataImporter()
    
    var data: [String] = []
    
    // the DataManager class would provide data management functionality here
}

var manager2 = DataManager2()
manager2.data.append("Some data")
manager2.data.append("Some more data")

/*
 Because it’s marked with the lazy modifier, the DataImporter instance for the importer property is only created when the importer property is first accessed, such as when its filename property is queried:
 */

print(manager2.importer.filename)
//the DataImporter instance for the importer property has now been created


// MARK: - Computed Properties

/*
 In addition to stored properties, classes, structures, and enumerations can define computed properties, which don’t actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.
*/

/*
 Shorthand Setter Declaration:
 If a computed property’s setter doesn’t define a name for the new value to be set, a default name of newValue is used.
*/

struct Person {
    var firstName: String
    var lastName: String
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        set(newFullName){
            print("AAAAA SET", newFullName)
            let components = newFullName.split(separator: " ")
            if let first = components.first, let last = components.last {
                firstName = String(first)
                lastName = String(last)
            }
//            let components = newValue.split(separator: " ")
//            if let first = components.first, let last = components.last {
//                firstName = String(first)
//                lastName = String(last)
//            }
        }
    }
}

var person = Person(firstName: "John", lastName: "Doe")
print(person.fullName) // Output: "John Doe"

person.fullName = "Jane Smith"
print(person.firstName) // Output: "Jane"
print(person.lastName) // Output: "Smith"


// MARK: - Read-Only Computed Properties

/*
 A computed property with a getter but no setter is known as a read- only computed property. A read-only computed property always returns a value, and can be accessed through dot syntax, but can’t be set to a different value.
*/

/*
 NOTE:
 You must declare computed properties—including read-only computed properties—as variable properties with the var keyword, because their value isn’t fixed. The let keyword is only used for constant properties, to indicate that their values can’t be changed once they’re set as part of instance initialization.
*/

struct Square {
    var n: Int
    
    var square: Int {
        n * n
    }
}

var n2 = Square(n: 5)
print(n2.square)


// MARK: - Property Observers

/*
 Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.
*/

/*
 You can add property observers in the following places:
 
 Stored properties that you define
 Stored properties that you inherit
 Computed properties that you inherit
*/

/*
 You have the option to define either or both of these observers on a property:
 
 // -> 'willSet' is called just before the value is stored.
 
 // -> 'didSet' is called immediately after the new value is stored.
 */

/*
 If you implement a willSet observer, it’s passed the new property value as a constant parameter. You can specify a name for this parameter as part of your willSet implementation. If you don’t write the parameter name and parentheses within your implementation, the parameter is made available with a default parameter name of newValue.

 Similarly, if you implement a didSet observer, it’s passed a constant parameter containing the old property value. You can name the parameter or use the default parameter name of oldValue. If you assign a value to a property within its own didSet observer, the new value that you assign replaces the one that was just set.
*/

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
    
    func calledWillSetAndDidSetWhenUsingInOut(step: inout Int){
        totalSteps = step
    }
}

var steps = 10
let stepCounter = StepCounter()
stepCounter.calledWillSetAndDidSetWhenUsingInOut(step: &steps)
//stepCounter.totalSteps = 10
//
stepCounter.totalSteps = 200


// MARK: - Property Wrappers

/*
 A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property. For example, if you have properties that provide thread- safety checks or store their underlying data in a database, you have to write that code on every property. When you use a property wrapper, you write the management code once when you define the wrapper, and then reuse that management code by applying it to multiple properties.
 */

@propertyWrapper
struct TwelveOrLess{
    private var number = 0
    var wrappedValue: Int {
        get {
            number
        }
        set {
            print(newValue, "AAAAA")
            if newValue > 100 || newValue < 0 {
                print("error")
            }
            number = min(newValue, 12)
            
        }
    }
}

struct SmallRectangle{
 @TwelveOrLess var height: Int
 @TwelveOrLess var width: Int
}

var x = SmallRectangle()
x.height = 99
x.width = 9999
print(x.height)
print(x.width)

// MARK: - Setting Initial Values for Wrapped Properties

/*
 The code in the examples above sets the initial value for the wrapped property by giving number an initial value in the definition of CheckUserAge. Code that uses this property wrapper can’t specify a different initial value for a property that’s wrapped by CheckUserAge— for example, the definition of Teacher can’t give age initial values. To support setting an initial value or other customization, the property wrapper needs to add an initializer.
  
 */

@propertyWrapper
struct CheckUserAge {
    private var age: Int
    private(set) var projectedValue: Bool
    
    var wrappedValue: Int {
        get {
            age
        }
        set {
            if newValue > 100 || newValue < 0 {
                projectedValue = false
                assertionFailure("The user age should be greater then 0 and a less then 100")
            }
            age = newValue
            projectedValue = true
        }
    }
    
    init() {
        age = 1
        projectedValue = false
    }

    init(wrappedValue: Int) {
        age = wrappedValue
        projectedValue = false
    }
}

struct Teacher {
    @CheckUserAge var age: Int = 20
}

struct Student {
    @CheckUserAge(wrappedValue: 30) var age: Int
}

struct Athlet {
    @CheckUserAge var age: Int
}

var t = Teacher()
print("TTTTT", t.$age)
t.age = 20
print("TTTTT", t.$age)

var s = Student()
print("SSSSSS", s.age)


// MARK: - Projecting a Value From a Property Wrapper

/*
 In addition to the wrapped value, a property wrapper can expose additional functionality by defining a projected value—for example, a property wrapper that manages access to a database can expose a flushDatabaseConnection() method on its projected value. The name of the projected value is the same as the wrapped value, except it begins with a dollar sign ($). Because your code can’t define properties that start with $ the projected value never interferes with properties you define.
 
 In the SmallNumber example above, if you try to set the property to a number that’s too large, the property wrapper adjusts the number before storing it. The code below adds a projectedValue property to the SmallNumber structure to keep track of whether the property wrapper adjusted the new value for the property before storing that new value.
 */

@propertyWrapper
struct SmallNumber{
    private var number: Int
    
    private(set) var projectedValue: Bool // projecting
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
        
    }
    
    init() {
        self.number = 0
        self.projectedValue = false
    }
    
}

struct SomeStructure{
    @SmallNumber var someNumber: Int
}

var someStructure=SomeStructure()
someStructure.someNumber=4
print(someStructure.$someNumber)

// MARK: - Global and Local Variables

/*
 The capabilities described above for computing and observing properties are also available to global variables and local variables. Global variables are variables that are defined outside of any function, method, closure, or type context. Local variables are variables that are defined within a function, method, or closure context.
 
 The global and local variables you have encountered in previous chapters have all been stored variables. Stored variables, like stored properties, provide storage for a value of a certain type and allow that value to be set and retrieved.
 
 However, you can also define computed variables and define observers for stored variables, in either a global or local scope. Computed variables calculate their value, rather than storing it, and they’re written in the same way as computed properties.
 */

func someFunction(){
    @CheckUserAge var myNumber: Int = 0
    myNumber = 10
    // now myNumber is 10
    myNumber = 24
    // now myNumber is 12
}

struct SomeStructure2{
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration{
static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        5
    }
}

class SomeClass{
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int
     {
         return 107
     }
}

print(SomeStructure2.storedTypeProperty)
//Prints"Somevalue."

SomeStructure2.storedTypeProperty="Anothervalue."
print(SomeStructure2.storedTypeProperty)
//Prints"Anothervalue."

print(SomeEnumeration.computedTypeProperty)
//Prints"6"

print(SomeClass.computedTypeProperty)
//Prints"27"


class Increment {
    static var count: Int = 0
    
    static func inc() -> Int{
        count += 1
        return count
    }
}

print(Increment.inc())
print(Increment.inc())
print(Increment.inc())
print(Increment.inc())


class MutatingClass {
    static private(set) var num = 0
    
//    func xxx(){
//        num += 1
//    }
    init() {
        Self.num += 1
        self.name = "Knyaz "
    }
    
    deinit {
        Self.num -= 1
    }
    
    var name: String  {
        willSet {
            print("aaa", newValue)
        }
        
        didSet {
            print("ddd", oldValue, name)
        }
    }
    
    static func xxx() {
        Self.num += 1
    }
    
    class func kkk() {
        Self.num += 1
    }
    
    lazy var age = 0
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:dd:yyyy"
        return formatter
    }()
    
}

struct MutatingStruct {
    var num = 0
    
    mutating func xxx(){
        self.num += 1
    }
}

let x4 = MutatingClass()

x4.name = "Hayk"



struct Matrix {
    var grid = [[Int]]()
    
    subscript(row row: Int, colume colume: Int) -> Int? {
        if grid.count > 0 && grid[row].count > colume {
            return grid[row][colume]
        }
        return nil
    }
}


var mtr = Matrix()

print(mtr.grid[0][3])

//mtr[row: 3, colume: 3]
