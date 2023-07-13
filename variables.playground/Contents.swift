

// MARK: Variables
/*
    Use let to make a constant and var to make a variable. The value of a constant doesn’t need to be known at compile time, but you must assign it a value exactly once. This means you can use constants to name a value that you determine once but use in many places.
 */

var myVariable = 99

myVariable = 88 // I can change when want

let myConstantVariable = 77

// myConstantVariable = 66 // ERROR: I can't chnage

var myInt : Int

myInt = 66


let myDouble : Double = 4.4

/*
 Use \() to include a floating-point calculation in a string and to include someone’s name in a greeting
 */

let apples = 5

let letappleSummary="I have \(apples  + Int(myDouble)) apples."

var x = true
if x {
    print(1)
}

// MARK: Arrays and Dictionary


/*
 Create arrays and dictionaries using brackets ([]), and access their elements by    writing the index or key in brackets. A comma is allowed after the last element.
 */

var myList = ["name1", "name2", "name3"]

myList[0]
myList
myList[1] = "Davo"
myList.remove(at: 0)

var myDict:[String : String] = [
    "name":"Knyaz",
    "age":"20",
]

myDict["name"] = "David"
myDict["age"]


let emptyArray:[String]=[]

let emptyDictionary:[String:Float]=[:]


// MARK: Type Aliases

/*
 Type aliases define an alternative name for an existing type. You define type aliases with the typealias keyword.
 
 Type aliases are useful when you want to refer to an existing type by a name that’s contextually more appropriate, such as when working with data of a specific size from an external source:
 */

typealias barec = Int

var kno : barec
var knnn : Int
knnn = 88
kno = 99

// MARK: Tuples

/*
 Tuples group multiple values into a single compound value. The values within a tuple can be of any type and don’t have to be of the same type as each other.
 
 In this example, (404, "Not Found") is a tuple that describes an HTTP status code. An HTTP status code is a special value returned by a web server whenever you request a web page. A status code of 404 Not Found is returned if you request a webpage that doesn’t exist.
 */

let http404Error = (404,"Not Found")
http404Error

/*
 The (404, "Not Found") tuple groups together an Int and a String to give the HTTP status code two separate values: a number and a human-readable description. It can be described as “a tuple of type (Int, String)”.
 */

let (statusCode,statusMessage) = http404Error

print("The status code is \(statusCode)")

print("The status message is \(statusMessage)")

/*
 Alternatively, access the individual element values in a tuple using index numbers starting at zero:
 */
print("The status code is \(http404Error.0)")

let http200Status = (statusCode: 200, description: "OK")
http200Status.statusCode

// MARK: Optionals

/*
 You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.
 */

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
convertedNumber

/*
 Because the initializer might fail, it returns an optional Int, rather than an Int. An optional Int is written as Int?, not Int. The question mark indicates that the value it contains is optional, meaning that it might contain some Int value, or it might contain no value at all. (It can’t contain anything else, such as a Bool value or a String value. It’s either an Int, or it’s nothing at all.)
 */

// MARK: Optional Binding

/*
 You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with if and while statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action. if and while statements are described in more detail in Control Flow.
 */

if let actualNumber = Int(possibleNumber) {
    print("This is my number \(actualNumber)")
} else {
    print("ERROR: This value cannot be intager")
}

if let convertedNumber {
    print("This is my number \(convertedNumber)")
} else {
    print("ERROR: This value cannot be intager")
}

if let firstNumber = Int("5") , let secondNumber = Int("54"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
} else {
    print("Not Working")
}

let possibleString : String? = "kkk"
let forcedString : String = possibleString != nil ? possibleString! : "null"
forcedString

// MARK: Error Handling

/*
 You use error handling to respond to error conditions your program may encounter during execution.
 */

func canThrowAnyError() throws {
    print("dd")
}

do {
    try canThrowAnyError()
} catch {
    print("I catch error")
}

// MARK: Assertions and Preconditions

/*
 Assertions and preconditions are checks that happen at runtime. You use them to make sure an essential condition is satisfied before executing any further code. If the Boolean condition in the assertion or precondition evaluates to true, code execution continues as usual. If the condition evaluates to false, the current state of the program is invalid; code execution ends, and your app is terminated.
 */


let age = 3 // if you want to see all errors age change to -(number) // -3

assert(age >= 0, "A person's age can't be less than zero.")

/*
 In this example, code execution continues if age >= 0 evaluates to true, that is, if the value of age is nonnegative. If the value of age is negative, as in the code above, then age >= 0 evaluates to false, and the assertion fails, terminating the application.
 */

/*
 If the code already checks the condition, you use the assertionFailure(_:file:line:) function to indicate that an assertion has failed. For example:
 */

if age > 10 {
    
} else if age >= 0 {
    
} else {
    assertionFailure("A person's age can't be less than zero.")
}

precondition(age > 0, "ERROR")
//preconditionFailure("ERROR")

/*
 If you compile in unchecked mode (-Ounchecked), preconditions aren’t checked. The compiler assumes that preconditions are always true, and it optimizes your code accordingly. However, the fatalError(_:file:line:) function always halts execution, regardless of optimization settings.
 
 You can use the fatalError(_:file:line:) function during prototyping and early development to create stubs for functionality that hasn’t been implemented yet, by writing fatalError("Unimplemented") as the stub implementation. Because fatal errors are never optimized out, unlike assertions or preconditions, you can be sure that execution always halts if it encounters a stub implementation.
 */
