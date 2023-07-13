// MARK: - Closures

/*
 Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.
 
 Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.
*/

/*
 Global functions are closures that have a name and don’t capture any values.
 
 Nested functions are closures that have a name and can capture values from their enclosing function.
 
 Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
*/

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted { s1, s2 in
    return s1 < s2
}

var reversedNames2 = names.sorted(by: backward)

var reversedNames3 = names.sorted(by: { (s1:String,s2: String) -> Bool in
 return s1 > s2
})

var reversedNames4 = names.sorted(by: { s1, s2 in s1 > s2 })

reversedNames
reversedNames2
reversedNames3
reversedNames4


// MARK: - Shorthand Argument Names

/*
 Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
*/

/*
 If you use these shorthand argument names within your closure expression, you can omit the closure’s argument list from its definition. The type of the shorthand argument names is inferred from the expected function type, and the highest numbered shorthand argument you use determines the number of arguments that the closure takes. The in keyword can also be omitted, because the closure expression is made up entirely of its body:
*/

var reversedNames5 = names.sorted(by: { $0 < $1 } )
/*
 Here, $0 and $1 refer to the closure’s first and second String arguments. Because $1 is the shorthand argument with highest number, the closure is understood to take two arguments. Because the sorted(by:) function here expects a closure whose arguments are both strings, the shorthand arguments $0 and $1 are both of type String.
*/
reversedNames5


// MARK: - Operator Methods

/*
 There’s actually an even shorter way to write the closure expression above. Swift’s String type defines its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type String, and returns a value of type Bool. This exactly matches the method type needed by the sorted(by:) method. Therefore, you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation:
*/

var reversedNames6 = names.sorted(by: <)
reversedNames6


func someFunctionThatTakesAClosure(closure: () -> Void) {
    print("ggg")
    closure()
}

someFunctionThatTakesAClosure() {
    print("dddd")
}


// should figur out

// MARK: - Capturing Values

/*
 A closure can capture constants and variables from the surrounding context in which it’s defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.
 
 In Swift, the simplest form of a closure that can capture values is a nested function, written within the body of another function. A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.
 
 Here’s an example of a function called makeIncrementer, which contains a nested function called incrementer. The nested incrementer() function captures two values, runningTotal and amount, from its surrounding context. After capturing these values, incrementer is returned by makeIncrementer as a closure that increments runningTotal by amount each time it’s called.
*/

func makeIncrementer(forIncrement amount:Int ) ->() -> Int {

    var total = 0
    func increment() -> Int {
        total += amount
        return total
    }
    return increment
}

let total = makeIncrementer(forIncrement: 10)
let total2 = makeIncrementer(forIncrement: 50)
total()
total()
total()

total2()
total2()
// this code above

func someFunction(completion: () -> Void) {
    // Perform some work or asynchronous operation

    // Call the closure after the work is done
    completion()
}

func handleCompletion() {
    print("Completion handled.")
}

someFunction(completion: handleCompletion)

//var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//print(customersInLine.count)
//// Prints "5"
//
//
//let customerProvider = { customersInLine.remove(at: 0) }
//print(customersInLine.count)
//// Prints "5"
//
//
//print("Now serving \(String(describing: customerProvider))!")
//// Prints "Now serving Chris!"
//print(customersInLine.count)
//// Prints "4"
//


func welcomeFunction(name: String, closure: (String) -> Void){
    closure(name)
}

welcomeFunction(name: "Knyaz") { param1 in
    print("Hello", param1)
}


var one = 60

var testing: () -> Void = {
    print(one)
}

testing()

one += 100

testing()
one += 100
testing()
