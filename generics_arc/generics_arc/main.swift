

// MARK: - Generics

/*
 Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.
 
 Generics are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code. In fact, you’ve been using generics throughout the Language Guide, even if you didn’t realize it. For example, Swift’s Array and Dictionary types are both generic collections. You can create an array that holds Int values, or an array that holds String values, or indeed an array for any other type that can be created in Swift. Similarly, you can create a dictionary to store values of any specified type, and there are no limitations on what that type can be.
*/


func swapTwoValues<T> (_ a: inout T, _ b: inout T) {
    let tmp = a
    a = b
    b = tmp
}

var a = 99
var b = 200

var c = "hello"
var d = "world"

var e = 34.45
var f = 9.45

swapTwoValues(&a, &b)

//print(a, b)

swapTwoValues(&c, &d)

//print(c, d)

swapTwoValues(&e, &f)

//print(e, f)


class Stack<T> : ExpressibleByArrayLiteral {
    
    required init(arrayLiteral elements: T...) {
        self._storage = elements
    }
    
    private var _storage = [T]()
    
    func push(_ elem: T) {
        _storage.append(elem)
    }
    
    func pop(){
        _storage.removeLast()
    }
    
    func printAll() {
        for i in _storage{
            print(i)
        }
    }
}

let stack: Stack<Int> = [1,2,3]
//stack.push(99)
//stack.push(22)
//stack.push(33)
//stack.printAll()
//stack.pop()
//stack.printAll()


// MARK: - Extending a Generic Type

/*
 When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition. Instead, the type parameter list from the original type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.
 
 The following example extends the generic Stack type to add a read- only computed property called topItem, which returns the top item on the stack without popping it from the stack:
*/

extension Stack{
    var topItem: T? {
        return _storage.isEmpty ? nil : _storage[_storage.count - 1]
    }
}

//print(stack.topItem)


// MARK: - Type Constraints

/*
 The swapTwoValues(_:_:) function and the Stack type can work with any type. However, it’s sometimes useful to enforce certain type constraints on the types that can be used with generic functions and generic types. Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
  
 For example, Swift’s Dictionary type places a limitation on the types that can be used as keys for a dictionary. As described in Dictionaries, the type of a dictionary’s keys must be hashable. That is, it must provide a way to make itself uniquely representable. Dictionary needs its keys to be hashable so that it can check whether it already contains a value for a particular key. Without this requirement, Dictionary couldn’t tell whether it should insert or replace a value for a particular key, nor would it be able to find a value for a given key that’s already in the dictionary.
 
 This requirement is enforced by a type constraint on the key type for Dictionary, which specifies that the key type must conform to the Hashable protocol, a special protocol defined in the Swift standard library. All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default. For information about making your own custom types conform to the Hashable protocol, see Conforming to the Hashable Protocol.
 
 You can define your own type constraints when creating custom generic types, and these constraints provide much of the power of generic programming. Abstract concepts like Hashable characterize types in terms of their conceptual characteristics, rather than their concrete type.
 
 Type Constraint Syntax:
 You write type constraints by placing a single class or protocol constraint after a type parameter’s name, separated by a colon, as part of the type parameter list. The basic syntax for type constraints on a generic function is shown below (although the syntax is the same for generic types):
*/

func findIndex<T: Equatable> (of valueToFind: T,in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex=findIndex(of:0.1,in:[3.14159, 0.1, 0.25])



protocol Container{
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

extension Stack: Container {
    typealias Item = T
    
    func append(_ item: T) {
        _storage.append(item)
    }
    
    subscript(i: Int) -> T {
        return _storage[i]
    }
    
    var count: Int {
        return _storage.count
    }
}


// MARK: - Generic Where Clauses

/*
 Type constraints, as described in Type Constraints, enable you to define requirements on the type parameters associated with a generic function, subscript, or type.
 
 It can also be useful to define requirements for associated types. You do this by defining a generic where clause. A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same. A generic where clause starts with the where keyword, followed by constraints for associated types or equality relationships between types and associated types. You write a generic where clause right before the opening curly brace of a type or function’s body.
 
 The example below defines a generic function called allItemsMatch, which checks to see if two Container instances contain the same items in the same order. The function returns a Boolean value of true if all items match and a value of false if they don’t.
 
 The two containers to be checked don’t have to be the same type of container (although they can be), but they do have to hold the same type of items. This requirement is expressed through a combination of type constraints and a generic where clause:
*/


extension Stack where T == Int {
    func xxx() {
        print(self._storage)
    }
}

stack.xxx()

let stackDouble = Stack<Double>()
stackDouble.append(4.5)
stackDouble.append(4.55)
stackDouble.append(222.5)

//stackDouble.xxx() for double type I don't have this method

// MARK: - Automatic Reference Counting

/*
 Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage. In most cases, this means that memory management “just works” in Swift, and you don’t need to think about memory management yourself. ARC automatically frees up the memory used by class instances when those instances are no longer needed.
 
 However, in a few cases ARC requires more information about the relationships between parts of your code in order to manage memory for you. This chapter describes those situations and shows how you enable ARC to manage all of your app’s memory. Using ARC in Swift is very similar to the approach described in Transitioning to ARC Release Notes for using ARC with Objective-C.
 
 Reference counting applies only to instances of classes. Structures and enumerations are value types, not reference types, and aren’t stored and passed by reference.

*/


// MARK: - How ARC Works

/*
 Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance. This memory holds information about the type of the instance, together with the values of any stored properties associated with that instance.
 
 Additionally, when an instance is no longer needed, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead. This ensures that class instances don’t take up space in memory when they’re no longer needed.
  
 However, if ARC were to deallocate an instance that was still in use, it would no longer be possible to access that instance’s properties, or call that instance’s methods. Indeed, if you tried to access the instance, your app would most likely crash.
 
 To make sure that instances don’t disappear while they’re still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
 
 To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and doesn’t allow it to be deallocated for as long as that strong reference remains.
*/


// MARK: - ARC in Action

/*
 Here’s an example of how Automatic Reference Counting works. This example starts with a simple class called Person, which defines a stored constant property called name:
*/

class Person{
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

func test() {
    _ = Person(name: "Kno")
}

//test()

//var reference1: Person?
//var reference2: Person?
//var reference3: Person?
//
//reference1 = Person(name:"John Appleseed")
//
//reference2 = reference1
//reference3 = reference1
//
//reference1 = nil
//reference2 = nil

/*
 There are now three strong references to this single Person instance.
 
 If you break two of these strong references (including the original reference) by assigning nil to two of the variables, a single strong reference remains, and the Person instance isn’t deallocated:
 
 reference1=nil
 reference2=nil
 
 ARC doesn’t deallocate the Person instance until the third and final strong reference is broken, at which point it’s clear that you are no longer using the Person instance:
 */

//reference3 = nil
// Prints "John Appleseed is being deinitialized"



class Man{
    let name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment{
    let unit: String
    var tenant: Man?
    
    init(unit: String) {
        self.unit = unit
    }
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

//var john: Man?
//var unit4A: Apartment?
//
//john = Man(name: "Kno")
//
//unit4A = Apartment(unit: "4A")
//
//john!.apartment = unit4A
//
//unit4A!.tenant = john

//john?.apartment = nil
//unit4A?.tenant = nil


/*
 Unfortunately, linking these two instances creates a strong reference cycle between them. The Person instance now has a strong reference to the Apartment instance, and the Apartment instance has a strong reference to the Person instance. Therefore, when you break the strong references held by the john and unit4A variables, the reference counts don’t drop to zero, and the instances aren’t deallocated by ARC:
*/

//john = nil
//unit4A = nil


// MARK: - Resolving Strong Reference Cycles Between Class Instances

/*
 Swift provides two ways to resolve strong reference cycles when you work with properties of class type: weak references and unowned references.
 
 Weak and unowned references enable one instance in a reference cycle to refer to the other instance without keeping a strong hold on it. The instances can then refer to each other without creating a strong reference cycle.
 
 Use a weak reference when the other instance has a shorter lifetime— that is, when the other instance can be deallocated first. In the Apartment example above, it’s appropriate for an apartment to be able to have no tenant at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case. In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.
*/


// MARK: - Weak References

/*
 A weak reference is a reference that doesn’t keep a strong hold on the instance it refers to, and so doesn’t stop ARC from disposing of the referenced instance. This behavior prevents the reference from becoming part of a strong reference cycle. You indicate a weak reference by placing the weak keyword before a property or variable declaration.
 
 Because a weak reference doesn’t keep a strong hold on the instance it refers to, it’s possible for that instance to be deallocated while the weak reference is still referring to it. Therefore, ARC automatically sets a weak reference to nil when the instance that it refers to is deallocated. And, because weak references need to allow their value to be changed to nil at runtime, they’re always declared as variables, rather than constants, of an optional type.
 
 You can check for the existence of a value in the weak reference, just like any other optional value, and you will never end up with a reference to an invalid instance that no longer exists.
*/

class Man2{
    let name: String
    var apartment: Apartment2?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment2{
    let unit: String
    weak var tenant: Man2?
    
    init(unit: String) {
        self.unit = unit
    }
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

//var john2: Man2?
//var unit4A2: Apartment2?
//
//john2 = Man2(name: "Kno")
//
//unit4A2 = Apartment2(unit: "4A")
//
//john2!.apartment = unit4A2
//
//unit4A2!.tenant = john2

/*
 The Person instance still has a strong reference to the Apartment instance, but the Apartment instance now has a weak reference to the Person instance. This means that when you break the strong reference held by the john variable by setting it to nil, there are no more strong references to the Person instance:
*/

//john2 = nil
//unit4A2 = nil


// MARK: - Unowned References

/*
 Like a weak reference, an unowned reference doesn’t keep a strong hold on the instance it refers to. Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime or a longer lifetime. You indicate an unowned reference by placing the unowned keyword before a property or variable declaration.
 
 Unlike a weak reference, an unowned reference is expected to always have a value. As a result, marking a value as unowned doesn’t make it optional, and ARC never sets an unowned reference’s value to nil.
 
 IMPORTANT:
 Use an unowned reference only when you are sure that the reference always refers to an instance that hasn’t been deallocated.
 
 If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.
*/

/*
 The following example defines two classes, Customer and CreditCard, which model a bank customer and a possible credit card for that customer. These two classes each store an instance of the other class as a property. This relationship has the potential to create a strong reference cycle.
 
 The relationship between Customer and CreditCard is slightly different from the relationship between Apartment and Person seen in the weak reference example above. In this data model, a customer may or may not have a credit card, but a credit card will always be associated with a customer. A CreditCard instance never outlives the Customer that it refers to. To represent this, the Customer class has an optional card property, but the CreditCard class has an unowned (and non-optional) customer property.
 
 Furthermore, a new CreditCard instance can only be created by passing a number value and a customer instance to a custom CreditCard initializer. This ensures that a CreditCard instance always has a customer instance associated with it when the CreditCard instance is created.
 
 Because a credit card will always have a customer, you define its customer property as an unowned reference, to avoid a strong reference cycle:
*/


class Customer {
    let name: String
    var creditCard: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned var customer: Customer
    
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var kno: Customer?

kno = Customer(name: "Knyaz")
kno!.creditCard = CreditCard(number:1234_5678_9012_3456, customer: kno!)

kno = nil


class HTMLElement{
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading=HTMLElement(name:"h1")
let defaultText="somedefaulttext"

heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}

print(heading.asHTML())

var paragraph:HTMLElement?=HTMLElement(name:"p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil

infix operator ???
infix operator %
postfix operator ++

extension Int {
    static func ??? (left: Int, right: Int) -> Int {
        return (left * right) * 3
    }
    
    static func %(left: Int, right: Int) -> Int {
        return (left * right) * 3
    }
    
    static postfix func ++(value: inout Int) -> Int {
        let tmp = value
        value += 1
        return value;
    }
}


var x = 99
print(x++)
