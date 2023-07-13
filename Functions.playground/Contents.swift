// MARK: - Functions

/*
 Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.
 
 Swift’s unified function syntax is flexible enough to express anything from a simple C-style function with no parameter names to a complex Objective-C-style method with names and argument labels for each parameter. Parameters can provide default values to simplify function calls and can be passed as in-out parameters, which modify a passed variable once the function has completed its execution.
 
 Every function in Swift has a type, consisting of the function’s parameter types and return type. You can use this type like any other type in Swift, which makes it easy to pass functions as parameters to other functions, and to return functions from functions. Functions can also be written within other functions to encapsulate useful functionality within a nested function scope.
*/


func greet(personName: String) -> String {
    let greeting = "Hello " + personName + "!"
    return greeting
}

greet(personName: "Kno")


// MARK: - Function Parameters and Return Values

/*
 Function parameters and return values are extremely flexible in Swift. You can define anything from a simple utility function with a single unnamed parameter to a complex function with expressive parameter names and different parameter options.
*/

func sayHelloWorld() -> String {
    return "Hello World"
}

sayHelloWorld()


// MARK: - Functions Without Return Values

/*
 Functions aren’t required to define a return type. Here’s a version of the greet(person:) function, which prints its own String value rather than returning it:
*/

func greeting(person: String){
    print("Hello \(person)!!!")
}

greeting(person: "Knyaz")

// MARK: - Functions with Multiple Return Values

/*
 You can use a tuple type as the return type for a function to return multiple values as part of one compound return value.
 
 The example below defines a function called minMax(array:), which finds the smallest and largest numbers in an array of Int values:
*/

func minMax(arr: [Int]) -> (min: Int, max: Int) {
    var minimum = arr[0]
    var maximum = arr[0]
    for num in arr[..<arr.count] {
        if num < minimum {
            minimum = num
        } else {
            maximum = num
        }
    }
    return (minimum, maximum)
}

let (min, max) =  minMax(arr: [23, 44, 66, 7, 44, 2222])


// MARK: - Optional Tuple Return Types
/*
 If the tuple type to be returned from a function has the potential to have “no value” for the entire tuple, you can use an optional tuple return type to reflect the fact that the entire tuple can be nil. You write an optional tuple return type by placing a question mark after the tuple type’s closing parenthesis, such as (Int, Int)? or (String, Int, Bool)?.
*/

/*
 NOTE
 An optional tuple type such as (Int, Int)? is different from a tuple that contains optional types such as (Int?, Int?). With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.
*/

func minMaxOptional(arr: [Int]) -> (min: Int, max: Int)? {
    if arr.isEmpty {
        return nil
    }
    var minimum = arr[0]
    var maximum = arr[0]
    for num in arr[..<arr.count] {
        if num < minimum {
            minimum = num
        } else {
            maximum = num
        }
    }
    return (minimum, maximum)
}


minMaxOptional(arr: [])

// MARK: - Functions With an Implicit Return

/*
 If the entire body of the function is a single expression, the function implicitly returns that expression. For example, both functions below have the same behavior:
 */

func implicitReturn() -> String {
    "Hello World Broo"
}

implicitReturn()

// MARK: - Function Argument Labels and Parameter Names

/*
 Each function parameter has both an argument label and a parameter name. The argument label is used when calling the function; each argument is written in the function call with its argument label before it. The parameter name is used in the implementation of the function. By default, parameters use their parameter name as their argument label.
*/


func someFunction(argumentLable myParameter: Int){
    print(myParameter)
}

someFunction(argumentLable: 44)


func greetHome(personName: String, form hometown: String) -> String {
    return "Hello \(personName)! Glad you could visit from \(hometown)."
}

greetHome(personName: "Knyaz", form: "Armenia")


// MARK: - Omitting Argument Labels

/*
 If you don’t want an argument label for a parameter, write an underscore (_) instead of an explicit argument label for that parameter.
*/


func someFunc(_ firstParamaeter: Int, secondeParamaeter: Int){
    print(firstParamaeter + secondeParamaeter)
}

someFunc(9, secondeParamaeter: 9)


// MARK: - Variadic Parameters

/*
 A variadic parameter accepts zero or more values of a specified type. You use a variadic parameter to specify that the parameter can be passed a varying number of input values when the function is called. Write variadic parameters by inserting three period characters (...) after the parameter’s type name.
 
 The values passed to a variadic parameter are made available within the function’s body as an array of the appropriate type. For example, a variadic parameter with a name of numbers and a type of Double... is made available within the function’s body as a constant array called numbers of type [Double].
 
 The example below calculates the arithmetic mean (also known as the average) for a list of numbers of any length:
*/

func variadicFunction(_ numbers: Int...) -> Int {
    var sum: Int = 0
    for num in numbers {
        sum += num
    }
    return sum
}

print(variadicFunction(1,2,3,4,5))


// MARK: - In-Out Parameters

/*
 Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
 
 You write an in-out parameter by placing the inout keyword right before a parameter’s type. An in-out parameter has a value that’s passed in to the function, is modified by the function, and is passed back out of the function to replace the original value. For a detailed discussion of the behavior of in-out parameters and associated compiler optimizations, see In-Out Parameters.
 
 You can only pass a variable as the argument for an in-out parameter. You can’t pass a constant or a literal value as the argument, because constants and literals can’t be modified. You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.
*/


/*
 NOTE:
 In-out parameters can’t have default values, and variadic parameters can’t be marked as inout.
*/

func foo(sum: inout Int){
    sum = 99
    print(sum)
}

var x = 44
foo(sum: &x)


func swapTwoInts(_ a:inout Int, _ b: inout Int) -> (a:Int, b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
    
    return (a, b)
}

var someInt=3
var anotherInt=107
print(swapTwoInts(&someInt,&anotherInt))


// MARK: - Function Types

/*
 Every function has a specific function type, made up of the parameter types and the return type of the function.
*/

/*
 Using Function Types
 You use function types just like any other types in Swift. For example, you can define a constant or variable to be of a function type and assign an appropriate function to that variable:
*/

func addTwoInts(_ a: Int, _ b:Int) -> Int{
    return a + b
}

func mulTwoInts(_ a: Int, _ b:Int) -> Int{
    return a * b
}

var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2,3))")


// MARK: - Function Types as Parameter Types

/*
 You can use a function type such as (Int, Int) -> Int as a parameter type for another function. This enables you to leave some aspects of a function’s implementation for the function’s caller to provide when the function is called.
 
 Here’s an example to print the results of the math functions from above:
*/

func printMathResult(_ mathFunction:(Int,Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(mulTwoInts,3,5)
print("ddd")


func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func stepForward(_ input: Int) -> Int {
    return input + 1
}

func chooseStepFunction(backward:Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
print(moveNearerToZero(3))
print("ddd")


// MARK: - Nested Functions

/*
 All of the functions you have encountered so far in this chapter have been examples of global functions, which are defined at a global scope. You can also define functions inside the bodies of other functions, known as nested functions.
 
 Nested functions are hidden from the outside world by default, but can still be called and used by their enclosing function. An enclosing function can also return one of its nested functions to allow the nested function to be used in another scope.
 
 You can rewrite the chooseStepFunction(backward:) example above to use and return nested functions:
*/

func chooseStepFunctionNested(backward:Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    
    return backward ? stepBackward : stepForward
}

var currentValueNested = -4
let moveNearerToZeroNested = chooseStepFunctionNested(backward: currentValue > 0)
print(moveNearerToZero(currentValueNested))

func nested(name:String) {
    func printName(input: String) {
        print(input)
    }
    
    printName(input: name)
}

nested(name: "Knoooo")

print("ddd")
