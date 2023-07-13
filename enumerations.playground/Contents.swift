
// MARK: - Enumerations

/*
 An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.
 
 If you are familiar with C, you will know that C enumerations assign related names to a set of integer values. Enumerations in Swift are much more flexible, and don’t have to provide a value for each case of the enumeration. If a value (known as a raw value) is provided for each enumeration case, the value can be a string, a character, or a value of any integer or floating-point type.
 
 Alternatively, enumeration cases can specify associated values of any type to be stored along with each different case value, much as unions or variants do in other languages. You can define a common set of related cases as part of one enumeration, each of which has a different set of values of appropriate types associated with it.
 
 Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration’s current value, and instance methods to provide functionality related to the values the enumeration represents. Enumerations can also define initializers to provide an initial case value; can be extended to expand their functionality beyond their original implementation; and can conform to protocols to provide standard functionality.
*/

enum CompossPoint: Int {
    case north
    case south
    case east = -2
    case west
}

var point = CompossPoint.east

point = .south
switch point {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}


// MARK: - Iterating over Enumeration Cases

/*
 For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. You enable this by writing : CaseIterable after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type. Here’s an example:
*/

enum Beverage: Int, CaseIterable {
 case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count

for i in Beverage.allCases {
    print(i.rawValue)
}

print("\(numberOfChoices) beverage savailable")

enum Countries {
    case armenian(habits: String, tradition: String, personCount: Int)
    case runssian(habits: String, tradition: String, personCount: Int)
}

let am = Countries.armenian(habits: "Duxov", tradition: "Qochari", personCount: 3_290_333)

// MARK: - Initializing from a Raw Value

/*
 If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil. You can use this initializer to try to create a new instance of the enumeration.
*/


let rawValueGet = CompossPoint(rawValue: 1)
rawValueGet
