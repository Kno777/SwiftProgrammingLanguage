//
//  main.swift
//  inheritance
//
//  Created by Kno Harutyunyan on 01.07.23.
//


enum OperatorType {
    case add
    case mul
    case div
    case sub
}

struct MathAction{
    var op1: Int
    var op2: Int
    var operatorType: OperatorType
}

class Calculator {
    var result: Int = 0
    
    lazy var preferAction: (_ operation: MathAction) -> Void = {
        operation in
        
            switch operation.operatorType {
            case .add:
                self.result = operation.op1 + operation.op2
            case .div:
                self.result = operation.op1 / operation.op2
            case .mul:
                self.result = operation.op1 * operation.op2
            case .sub:
                self.result = operation.op1 - operation.op2
            
        }
    }
}

var mathOperation = MathAction(op1: 5, op2: 5, operatorType: .mul)
//let cal = Calculator()
//
//cal.preferAction(mathOperation)
//
//print(cal.result)


// MARK: - Inheritance

/*
 A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a subclass, and the class it inherits from is known as its superclass. Inheritance is a fundamental behavior that differentiates classes from other types in Swift.
 
 Classes in Swift can call and access methods, properties, and subscripts belonging to their superclass and can provide their own overriding versions of those methods, properties, and subscripts to refine or modify their behavior. Swift helps to ensure your overrides are correct by checking that the override definition has a matching superclass definition.
 
 Classes can also add property observers to inherited properties in order to be notified when the value of a property changes. Property observers can be added to any property, regardless of whether it was originally defined as a stored or computed property.
*/

class Vehicle1{
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
     // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

let v = Vehicle1()
print("Vehicle:\(v.description)")

// MARK: - Subclassing

/*
 Subclassing is the act of basing a new class on an existing class. The subclass inherits characteristics from the existing class, which you can then refine. You can also add new characteristics to the subclass.
 
 To indicate that a subclass has a superclass, write the subclass name before the superclass name, separated by a colon:
*/

class Bicycle: Vehicle1{
    var hasBasket = false
}

//let bicycle = Bicycle()
//let vehicle = Vehicle()
//
//bicycle.hasBasket=true
//bicycle.currentSpeed = 15.0
//print("Bicycle:\(bicycle.description)")
//print("Vehicle:\(vehicle.description)")

class Tandem: Bicycle {
    var  currentNumberOfPassengers = 0
}

//let tandem=Tandem()
//tandem.hasBasket=true
//tandem.currentNumberOfPassengers=2
//tandem.currentSpeed=22.0
//print("Tandem:\(tandem.description)")

// MARK: - Overriding

/*
 A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.
 
 To override a characteristic that would otherwise be inherited, you prefix your overriding definition with the override keyword. Doing so clarifies that you intend to provide an override and haven’t provided a matching definition by mistake. Overriding by accident can cause unexpected behavior, and any overrides without the override keyword are diagnosed as an error when your code is compiled.
 
 The override keyword also prompts the Swift compiler to check that your overriding class’s superclass (or one of its parents) has a declaration that matches the one you provided for the override. This check ensures that your overriding definition is correct.
*/

/*
 Accessing Superclass Methods, Properties, and Subscripts:
 When you provide a method, property, or subscript override for a subclass, it’s sometimes useful to use the existing superclass implementation as part of your override. For example, you can refine the behavior of that existing implementation, or store a modified value in an existing inherited variable.
 
 Where this is appropriate, you access the superclass version of a method, property, or subscript by using the super prefix:
 
 An overridden method named someMethod() can call the superclass version of someMethod() by calling super.someMethod() within the overriding method implementation.
 
 An overridden property called someProperty can access the superclass version of someProperty as super.someProperty within the overriding getter or setter implementation.
 
 An overridden subscript for someIndex can access the superclass version of the same subscript as super[someIndex] from within the overriding subscript implementation.
 */

class Train: Vehicle1{
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
//train.makeNoise()


// MARK: - Overriding Properties

/*
 You can override an inherited instance or type property to provide your own custom getter and setter for that property, or to add property observers to enable the overriding property to observe when the underlying property value changes.
 
 Overriding Property Getters and Setters:
 You can provide a custom getter (and setter, if appropriate) to override any inherited property, regardless of whether the inherited property is implemented as a stored or computed property at source. The stored or computed nature of an inherited property isn’t known by a subclass—it only knows that the inherited property has a certain name and type. You must always state both the name and the type of the property you are overriding, to enable the compiler to check that your override matches a superclass property with the same name and type.
 */

/*
 NOTE:
 If you provide a setter as part of a property override, you must also provide a getter for that override. If you don’t want to modify the inherited property’s value within the overriding getter, you can simply pass through the inherited value by returning super.someProperty from the getter, where someProperty is the name of the property you are overriding.
*/

class Car: Vehicle1{
    var gear = 1
    override var description: String {
        get {
            return super.description + " in gear \(gear)"
        }
        
        set {
            if let newSpeed = Double(newValue) {
                currentSpeed = newSpeed
            }
        }
        
    }
}

//let car=Car()
//car.currentSpeed=25.0
//car.gear=3
//car.description = "69"
//print("Car:\(car.description)")

// MARK: - Overriding Property Observers

/*
 You can use property overriding to add property observers to an inherited property. This enables you to be notified when the value of an inherited property changes, regardless of how that property was originally implemented. For more information on property observers, see Property Observers.
 
 NOTE:
 You can’t add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties can’t be set, and so it isn’t appropriate to provide a willSet or didSet implementation as part of an override.
 
 Note also that you can’t provide both an overriding setter and an overriding property observer for the same property. If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.
 */



class AutomaticCar: Car{
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed=35.0
//print("AutomaticCar:\(automatic.description)")

// MARK: - Preventing Overrides

/*
 You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript).
 */

final class DontInherited {
    
    final var dontInheritedThisProperty: Int = 9
    
    final func dontInheritedMethod() {
        print("You cannot inherited this method")
    }
    
}

//class A : DontInherited {
//    
//} -> ERROR: You cannot inherited class, func, property, subscript, and so on when defined with final keyword.


class Base {
    private(set) var fname: String
    private var lname: String
    
    var fullname: String {
        get {
            fname + " " + lname
        }
        
        set {
            let names = newValue.split(separator: " ")
            guard names.count > 1 else {
                print("You have problem with array index.")
                return
            }
            
            fname = String(names[0])
            lname = String(names[1])
        }
    }
    
    init(fname: String, lname: String) {
        self.fname = fname
        self.lname = lname
    }
    
    func chnageName(name:String){
        self.fname = name
    }
}

class Child: Base {
    var age: Int
    
    init(fname: String, lname: String, age: Int) {
        self.age = age
        super.init(fname: fname, lname: lname)
    }
    
    init(age: Int) {
        self.age = age
        super.init(fname: "init", lname: "init")
    }
}

//let base = Base(fname: "Kno", lname: "Harutyunyan")
//base.chnageName(name: "Hakob")
//print(base.fullname)
//let child = Child(fname: "Davo", lname: "Harutyunyan", age: 23)
//let child2 = Child(age: 77)
//print(child.fullname)
//print(child.age)
//print(child2.age)
//child2.chnageName(name: "Dero")
//print(child2.fullname)


// MARK: - Initialization

/*
 Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s required before the new instance is ready for use.
 
 You implement this initialization process by defining initializers, which are like special methods that can be called to create a new instance of a particular type. Unlike Objective-C initializers, Swift initializers don’t return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.
 
 Instances of class types can also implement a deinitializer, which performs any custom cleanup just before an instance of that class is deallocated. For more information about deinitializers, see Deinitialization.
*/

/*
 Setting Initial Values for Stored Properties:
 
 Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties can’t be left in an indeterminate state.
 
 You can set an initial value for a stored property within an initializer, or by assigning a default property value as part of the property’s definition. These actions are described in the following sections.
 
 NOTE:
 When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
 */


//struct Fahrenheit{
//    var temperature: Double
//
//    init() {
//        temperature = 32.0
//    }
//}
//
//var f=Fahrenheit()
//print("The default temperature is \(f.temperature)° Fahrenheit")

struct Fahrenheit{
    var temperature: Double
}

let k = Fahrenheit(temperature: 34.0)


// MARK: - Memberwise Initializers for Structure Types

/*
 Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.
 
 The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.
 */

struct Size{
    var width: Int
    var height: Int
}

let size = Size(width: 23, height: 344)


// MARK: - Class Inheritance and Initialization

/*
 All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.
 
 Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value. These are known as designated initializers and convenience initializers.

 */

class A {
    var a = 1
}

class B: A {
    func aaa() {
        print(a)
    }
}

let b = B()
b.aaa()

// MARK: - Designated Initializers and Convenience Initializers

/*
 Designated initializers:
 
 Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
 
 Classes tend to have very few designated initializers, and it’s quite common for a class to have only one. Designated initializers are “funnel” points through which initialization takes place, and through which the initialization process continues up the superclass chain.
 
 Every class must have at least one designated initializer. In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass, as described in Automatic Initializer Inheritance below.
 */

/*
 Convenience initializers:
 
 Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.
 
 You don’t have to provide convenience initializers if your class doesn’t require them. Create convenience initializers whenever a shortcut to a common initialization pattern will save time or make initialization of the class clearer in intent.
 */

// MARK: - Initializer Delegation for Class Types

/*
 To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
 
 Rule 1:
 A designated initializer must call a designated initializer from its immediate superclass.
 
 Rule 2:
 A convenience initializer must call another initializer from the same class.
 
 Rule 3:
 A convenience initializer must ultimately call a designated initializer.
 
 A simple way to remember this is:
 Designated initializers must always delegate up.
 Convenience initializers must always delegate across.
 */


// MARK: - Two-Phase Initialization

/*
 Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.
 
 The use of a two-phase initialization process makes initialization safe, while still giving complete flexibility to each class in a class hierarchy. Two-phase initialization prevents property values from being accessed before they’re initialized, and prevents property values from being set to a different value by another initializer unexpectedly.
 */

/*
 Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:
 
 Safety check 1:
 A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
 
 As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before it hands off up the chain.
 
 
 Safety check 2:
 A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
 
 
 Safety check 3:
 A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.

 
 Safety check 4:
 An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
 
 The class instance isn’t fully valid until the first phase ends. Properties can only be accessed, and methods can only be called, once the class instance is known to be valid at the end of the first phase.
 */

/*
 Phase 1:
 A designated or convenience initializer is called on a class.
 
 Memory for a new instance of that class is allocated. The memory isn’t yet initialized.
 
 A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
 
 The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
 
 This continues up the class inheritance chain until the top of the chain is reached.
 
 Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
 */

/*
 Phase 2:
 Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
 
 Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
 */

class Vehicle{
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle=Vehicle()
print("Vehicle:\(vehicle.description)")


class Bicycle2: Vehicle{
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle2 = Bicycle2()
//print("Bicycle:\(bicycle2.description)")



 
class Hoverboard:Vehicle{
    var color: String
    init(color: String) {
        self.color = color
//        super.init()
//        numberOfWheels = 99
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}


let hoverboard = Hoverboard(color:"black")
//print("Hoverboard:\(hoverboard.description)")

// MARK: -  Automatic Initializer Inheritance

/*
 As mentioned above, subclasses don’t inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met. In practice, this means that you don’t need to write initializer overrides in many common scenarios, and can inherit your superclass initializers with minimal effort whenever it’s safe to do so.
 
 Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:
 
 Rule 1:
 If your subclass doesn’t define any designated initializers, it
 automatically inherits all of its superclass designated initializers.
 
 Rule 2:
 If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
 
 These rules apply even if your subclass adds further convenience initializers.
 
 NOTE
 A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
*/

/*
 Designated and Convenience Initializers in Action:
 
 The following example shows designated initializers, convenience initializers, and automatic initializer inheritance in action. This example defines a hierarchy of three classes called Food, RecipeIngredient, and ShoppingListItem, and demonstrates how their initializers interact.
 
 The base class in the hierarchy is called Food, which is a simple class to encapsulate the name of a foodstuff. The Food class introduces a single String property called name and provides two initializers for creating Food instances:
 */


class Food {
    var name:String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name:"Bacon")
print(namedMeat.name)
let mysteryMeat = Food()
print(mysteryMeat.name)

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    
    var full: String {
        return "\(name) and \(quantity)"
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name:"Bacon")
let sixEggs = RecipeIngredient(name:"Eggs",quantity: 6)

print(oneMysteryItem.full)
print(oneBacon.full)
print(sixEggs.full)

class ShoppingListItem:RecipeIngredient{
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList=[
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name="Orange juice"
breakfastList[0].purchased=true
for item in breakfastList {
    print(item.description)
}


// MARK: -  Failable Initializers

/*
 Failable Initializers
 It’s sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.
 */

struct Animal {
    var species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let someCreature=Animal(species:"Giraffe")

if let giraffe = someCreature{
    print("An animal was initialized with a species of \(giraffe.species)")
}


let anonymousCreature=Animal(species:"")

if anonymousCreature == nil {
    print("The anonymous creature couldn't be initialized")
}

// MARK: - Failable Initializers for Enumerations

/*
 You can use a failable initializer to select an appropriate enumeration case based on one or more parameters. The initializer can then fail if the provided parameters don’t match an appropriate enumeration case.
 
 The example below defines an enumeration called TemperatureUnit, with three possible states (kelvin, celsius, and fahrenheit). A failable initializer is used to find an appropriate enumeration case for a Character value representing a temperature symbol:
*/

enum TemperatureUnit{
    case kelvin, celsius, fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

//let fahrenheitUnit = TemperatureUnit(symbol:"F")
//
//if fahrenheitUnit != nil{
//    print("This is a defined temperature unit, so initialization succeeded.")
//}
//
//let unknownUnit = TemperatureUnit(symbol:"X")
//
//if unknownUnit == nil {
//    print("This isn't a defined temperature unit, so initialization failed.")
//}




class Product{
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product{
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name:"stock",quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
} else {
    print("Not working")
}

if let zeroShirts = CartItem(name:"shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initializer zero shirt")
}


// MARK: - Overriding a Failable Initializer

/*
 You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass nonfailable initializer. This enables you to define a subclass for which initialization can’t fail, even though initialization of the superclass is allowed to fail.
 
 Note that if you override a failable superclass initializer with a nonfailable subclass initializer, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer.
 
 The example below defines a class called Document. This class models a document that can be initialized with a name property that’s either a nonempty string value or nil, but can’t be an empty string:
 
 NOTE
 You can override a failable initializer with a nonfailable initializer but not the other way around.
*/

class Document{
    var name: String?

    init() {}
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document{
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument:Document{
    override init() {
        super.init(name: "[Untitled]")!
    }
}

let document = Document(name: "swift")
let autoDocument = AutomaticallyNamedDocument(name: "c++")
let unNamedDoc = UntitledDocument()

//print(document?.name ?? "a")
//print(autoDocument.name!)
//print(unNamedDoc.name!)


// MARK: - Required Initializers

/*
 Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
*/

class SomeClass{
    var n: String
    required init(n: String) {
        self.n = n
        print("required init SomeClass")
    }
}

class SomeSubclass: SomeClass{
    var name: String
    var x: Int
    init(n: String, x:Int) {
        self.name = n
        self.x = x
        super.init(n: "some")
    }
    
    required init(n: String) {
        self.name = ""
        self.x = 99
        super.init(n: n)
     }
}

let s = SomeSubclass(n: "ddd")


// MARK: - Setting a Default Property Value with a Closure or Function

/*
 If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property. Whenever a new instance of the type that the property belongs to is initialized, the closure or function is called, and its return value is assigned as the property’s default value.
 
 These kinds of closures or functions typically create a temporary value of the same type as the property, tailor that value to represent the desired initial state, and then return that temporary value to be used as the property’s default value.
 
 Here’s a skeleton outline of how a closure can be used to provide a default property value:
 */


class SettingDefaultProperty{
    let someProperty: Int = {
        return 5
    }()
}

let def = SettingDefaultProperty()

print(def.someProperty)

/*
 Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
*/


struct Chessboard{
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8{
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) ->
     Bool {
        return boardColors[(row * 8) + column]
    }
}

//let board=Chessboard()
//
//print(board.squareIsBlackAt(row:0,column:1))
//
//print(board.squareIsBlackAt(row:7,column:7))


// MARK: - Deinitialization

/*
 A deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the deinit keyword, similar to how initializers are written with the init keyword. Deinitializers are only available on class types.
*/

/*
 How Deinitialization Works:
 
 Swift automatically deallocates your instances when they’re no longer needed, to free up resources. Swift handles the memory management of instances through automatic reference counting (ARC), as described in Automatic Reference Counting. Typically you don’t need to perform manual cleanup when your instances are deallocated. However, when you are working with your own resources, you might need to perform some additional cleanup yourself. For example, if you create a custom class to open a file and write some data to it, you might need to close the file before the class instance is deallocated.
 
 Class definitions can have at most one deinitializer per class. The deinitializer doesn’t take any parameters and is written without parentheses:
*/

class DenitExample {
    deinit {
        print("clean up my class")
    }
}

/*
 Deinitializers are called automatically, just before instance deallocation takes place. You aren’t allowed to call a deinitializer yourself. Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation. Superclass deinitializers are always called, even if a subclass doesn’t provide its own deinitializer.
 
 Because an instance isn’t deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it’s called on and can modify its behavior based on those properties (such as looking up the name of a file that needs to be closed).
 */

class DeinitBase {
    init() {
        print("Init for DeinitBase")
    }
    
    deinit {
        print("Deinit fot DeinitBase")
    }
}

class DeinitChild: DeinitBase {
    override init() {
        print("Init for DeinitChild")
        super.init()
    }
    
    deinit {
        print("Deinit fot DeinitChild")
    }
}


var child: DeinitChild? = DeinitChild()
child = nil

