// MARK: - Structures and Classes

/*
 Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code. You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions.
 
 Unlike other programming languages, Swift doesn’t require you to create separate interface and implementation files for custom structures and classes. In Swift, you define a structure or class in a single file, and the external interface to that class or structure is automatically made available for other code to use.
*/

// MARK: - Comparing Structures and Classes

/*
 // Structures and classes in Swift have many things in common. Both can:
 
 Define properties to store values
 
 Define methods to provide functionality
 
 Define subscripts to provide access to their values using subscript syntax
 
 Define initializers to set up their initial state
 
 Be extended to expand their functionality beyond a default implementation
 
 Conform to protocols to provide standard functionality of a certain kind
 
 // Classes have additional capabilities that structures don’t have:
 
 Inheritance enables one class to inherit the characteristics of
 another.
 
 Type casting enables you to check and interpret the type of a
 class instance at runtime.
 
 Deinitializers enable an instance of a class to free up any
 resources it has assigned.
 
 Reference counting allows more than one reference to a class
 instance.
*/


struct SomeStructure {
    // defining structure
}

class SomeClass {
    // defining class
}

/*
 NOTE:
 Whenever you define a new structure or class, you define a new Swift type. Give types UpperCamelCase names (such as SomeStructure and SomeClass here) to match the capitalization of standard Swift types (such as String, Int, and Bool). Give properties and methods lowerCamelCase names (such as frameRate and incrementCount) to differentiate them from type names
*/

struct Resolution{
    var width = 0
    var height = 0
}

class VideoMode{
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()
let vga = Resolution(width: 640, height: 480)

print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
print("The width of vga is \(vga.width) and \(vga)")


// MARK: - Structures and Enumerations Are Value Types

/*
 A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.
 
 You’ve actually been using value types extensively throughout the previous chapters. In fact, all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries— are value types, and are implemented as structures behind the scenes.
 
 All structures and enumerations are value types in Swift. This means that any structure and enumeration instances you create—and any value types they have as properties—are always copied when they’re passed around in your code.
*/

/*
 NOTE:
 Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies. If one of the copies of the collection is modified, the elements are copied just before the modification. The behavior you see in your code is always as if a copy took place immediately.
*/

let hd = Resolution(width:1920,height:1080)
var cinema = hd

print("CINEAM: ", cinema)
print("HD: ", hd)

cinema.width = 2048

print("CHANGED CINEAM: ", cinema)
print("STILL SAME HD: ", hd)

// The same behavior applies to enumerations:

enum CompassPoint2 {
case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}

var currentDirection = CompassPoint2.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("There membered direction is \(rememberedDirection)")


let tenEighty = VideoMode()

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print(tenEighty.frameRate)
print(alsoTenEighty.frameRate)


// MARK: - Identity Operators

/*
 Because classes are reference types, it’s possible for multiple constants and variables to refer to the same single instance of a class behind the scenes. (The same isn’t true for structures and enumerations, because they’re always copied when they’re assigned to a constant or variable, or passed to a function.)
 
 It can sometimes be useful to find out whether two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:
 
 Identical to (===)
 Not identical to (!==)
 
 Use these operators to check whether two constants or variables refer
 to the same single instance:
*/

if tenEighty === alsoTenEighty{
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
} else {
    print("Not equal")
}


var nums = [2,33,33,2]
