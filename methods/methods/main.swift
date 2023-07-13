
// MARK: - Methods

/*
 Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself. Type methods are similar to class methods in Objective-C.
 
 The fact that structures and enumerations can define methods in Swift is a major difference from C and Objective-C. In Objective-C, classes are the only types that can define methods. In Swift, you can choose whether to define a class, structure, or enumeration, and still have the flexibility to define methods on the type you create.
*/


// MARK: - Instance Methods

/*
 Instance methods are functions that belong to instances of a particular class, structure, or enumeration. They support the functionality of those instances, either by providing ways to access and modify instance properties, or by providing functionality related to the instance’s purpose. Instance methods have exactly the same syntax as functions, as described in Functions.
 
 You write an instance method within the opening and closing braces of the type it belongs to. An instance method has implicit access to all other instance methods and properties of that type. An instance method can be called only on a specific instance of the type it belongs to. It can’t be called in isolation without an existing instance.
*/

class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

let counter=Counter()

counter.increment()
print(counter.count)
counter.increment(by:5)
print(counter.count)
counter.reset()
print(counter.count)


// MARK: - The self Property

/*
 Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.
 
 The increment() method in the example above could have been written like this:
 
 The main exception to this rule occurs when a parameter name for an instance method has the same name as a property of that instance. In this situation, the parameter name takes precedence, and it becomes necessary to refer to the property in a more qualified way. You use the self property to distinguish between the parameter name and the property name.
*/


// MARK: - Modifying Value Types from Within Instance Methods

/*
 Structures and enumerations are value types. By default, the properties of a value type can’t be modified from within its instance methods.
 
 However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method. The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.
 
 You can opt in to this behavior by placing the mutating keyword before the func keyword for that method:
 */

enum Greeting {
    static func sayHello() {
        print("Hello, World!")
    }
}

// Calling the enum function
Greeting.sayHello() // Output: "Hello, World!"

struct Person {
    var name: String = "Kno"
    
    mutating func chnageName(by newName: String) {
        self.name = newName
    }
}

var x = Person()
print(x.name)
x.chnageName(by: "David")
print(x.name)


// MARK: - Type Methods

/*
 Instance methods, as described above, are methods that you call on an instance of a particular type. You can also define methods that are called on the type itself. These kinds of methods are called type methods. You indicate type methods by writing the static keyword before the method’s func keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that method.
*/

class Shape {
    class func draw() {
        print("Drawing a shape.")
    }
    
    static func draw2() {
        print("Drawing a shape.")
    }
}

class Circle: Shape {
    override class func draw() {
        print("Drawing a circle.")
    }
}

class Rectangle: Shape {
    override class func draw() {
        print("Drawing a rectangle.")
    }
}


class A {
    class func xxx() {
        print("aaa")
    }
}

class B : A {
    override class func xxx() {
        print("bbbb")
    }
}

A.xxx()
let b = B()

// MARK: - Subscripts

/*
 Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval. For example, you access elements in an Array instance as someArray[index] and elements in a Dictionary instance as someDictionary[key].
 
 You can define multiple subscripts for a single type, and the appropriate subscript overload to use is selected based on the type of index value you pass to the subscript. Subscripts aren’t limited to a single dimension, and you can define subscripts with multiple input parameters to suit your custom type’s needs.
*/


struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let num = TimesTable(multiplier: 3)
print(num[3])

// MARK: - Type Subscripts

/*
 Instance subscripts, as described above, are subscripts that you call on an instance of a particular type. You can also define subscripts that are called on the type itself. This kind of subscript is called a type subscript. You indicate a type subscript by writing the static keyword before the subscript keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that subscript. The example below shows how you define and call a type subscript:
*/

enum Planet:Int{
case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

let mars=Planet[4]
print(mars)
