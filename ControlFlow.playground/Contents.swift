// MARK: - Control Flow

/*
 Swift provides a variety of control flow statements. These include while loops to perform a task multiple times; if, guard, and switch statements to execute different branches of code based on certain conditions; and statements such as break and continue to transfer the flow of execution to another point in your code.
*/


// MARK: - For-In Loops

/*
 You use the for-in loop to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string.
*/

let numbers = [11,22,33,44,55]

//for num in numbers{
//    print(num)
//}

let numberOfLegs = ["spider":8, "ant":6, "cat":4]

for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}


for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

/*
 The sequence being iterated over is a range of numbers from 1 to 5, inclusive, as indicated by the use of the closed range operator (...).
*/

func fact(base: Int) -> Int{
    var result = 1
    for i in 1...base {
        result *= i
    }
    return result
}

print(fact(base: 5))


let minuteInterval = 5
let minutes=60

/*
 if I put "to" property it does not included last item if I put "through" property it does include last item.
 For Example see in below.
 */
for tickMark in stride(from:0, through: minutes, by: minuteInterval) {
    print(tickMark, terminator: " ")
}
print("\n")
for tickMark in stride(from:0, to: minutes, by: minuteInterval) {
    print(tickMark, terminator: " ")
}
print("\n")

// MARK: - While

var num = 0
while num <= 5{
    print(num, terminator: " ")
    num += 1
}

// MARK: - Repeat-While === Do-While

repeat {
    print(num, terminator: " ")
    num += 1
} while num < 5


// MARK: - Switch
/*
 A switch statement considers a value and compares it against several possible matching patterns. It then executes an appropriate block of code, based on the first pattern that matches successfully. A switch statement provides an alternative to the if statement for responding to multiple potential states.
 
 In its simplest form, a switch statement compares a value against one or more values of the same type.
*/
print("\n")

let someCharacter:Character = "z"
let anotherCharacter:Character = "a"

switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

switch anotherCharacter {
case "a", "A":
    print("The letter a and A.")
default:
    print("Bye")
}

// MARK: - Switch Interval Matching

/*
 Values in switch cases can be checked for their inclusion in an interval. This example uses number intervals to provide a natural-language count for numbers of any size:
*/

let approximateCount=62
let countedThings="moons orbiting Saturn"
let naturalCount:String

switch approximateCount {
case 0:
naturalCount = "no"
case 1..<5:
naturalCount = "a few"
case 5..<12:
naturalCount = "several"
case 12..<100:
naturalCount = "dozens of"
case 100..<1000:
naturalCount = "hundreds of"
default:
    naturalCount = "many"
}

print("There are \(naturalCount) \(countedThings).")


let someNumber = 12

switch someNumber {
case 0:
    print("no")
case 1..<5:
    print("the number falls between 1 and 4")
case 10..<25:
    print("the number falls between 10 and 24")
case 50...100:
    print("the number falls between 50 and 100")
default:
    print("The number is bigger than 100")
}


// MARK: - Tuples

/*
 You can use tuples to test multiple values in the same switch statement. Each element of the tuple can be tested against a different value or interval of values. Alternatively, use the underscore character (_), also known as the wildcard pattern, to match any possible value.
*/

let somePoint=(0,4)

switch somePoint{
case(0,0):
    print("\(somePoint) is at the origin")
case(_,0):
    print("\(somePoint) is on the x-axis")
case(0,_):
    print("\(somePoint) is on the y-axis")
case(-2...2,-2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

// MARK: - Value Bindings

/*
 A switch case can name the value or values it matches to temporary constants or variables, for use in the body of the case. This behavior is known as value binding, because the values are bound to temporary constants or variables within the case’s body.
*/

let anotherPoint = (2,0)

switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}


// MARK: - Where

/*
 A switch case can use a where clause to check for additional conditions.
*/

let yetAnotherPoint = (1, 44)

switch yetAnotherPoint {
case let(x,y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let(x,y)where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

// MARK: - Fallthrough

/*
 In Swift, switch statements don’t fall through the bottom of each case and into the next one. That is, the entire switch statement completes its execution as soon as the first matching case is completed. By contrast, C requires you to insert an explicit break statement at the end of every switch case to prevent fallthrough. Avoiding default fallthrough means that Swift switch statements are much more concise and predictable than their counterparts in C, and thus they avoid executing multiple switch cases by mistake.
 
 If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case basis with the fallthrough keyword. The example below uses fallthrough to create a textual description of a number.
*/

let number = 9

switch number {
case 9:
    print("My number is \(9)")
    fallthrough
case 10:
    print("Aleady my number is \(10)")
    fallthrough
default:
    print("go out")
}

let nums = [Int](repeating: 5, count: 8)
nums.count

// MARK: - Labeled Statements

/*
 In Swift, you can nest loops and conditional statements inside other loops and conditional statements to create complex control flow structures. However, loops and conditional statements can both use the break statement to end their execution prematurely. Therefore, it’s sometimes useful to be explicit about which loop or conditional statement you want a break statement to terminate. Similarly, if you have multiple nested loops, it can be useful to be explicit about which loop the continue statement should affect.
 
 To achieve these aims, you can mark a loop statement or conditional statement with a statement label. With a conditional statement, you can use a statement label with the break statement to end the execution of the labeled statement. With a loop statement, you can use a statement label with the break or continue statement to end or continue the execution of the labeled statement.
*/

//outerloop: for i in 1...3 {
//  for j in 1...3 {
//    if i == 2 && j == 2 {
//      // exit the outer loop when i is equal to 2 and j is equal to 2
//      continue outerloop
//    }
//    print("i: \(i), j: \(j)")
//  }
//}

outerLoop: for i in 1...3 {
    innerLoop: for j in 1...3 {
        if i == 2 && j == 2 {
            print("Breaking out of both loops")
        }
        print("i: \(i), j: \(j)")
    }
}


// MARK: - Early Exit -- Guard statement

/*
 A guard statement, like an if statement, executes statements depending on the Boolean value of an expression. You use a guard statement to require that a condition must be true in order for the code after the guard statement to be executed. Unlike an if statement, a guard statement always has an else clause —the code inside the else clause is executed if the condition isn’t true.
*/

func greet(person: [String: String]) {
    
    guard let name = person["name"] else {
        print("working else block")
        return
    }
    
    print("Hello \(name)!")
    
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person:["name":"Kno"])
greet(person:["name":"Jane","location":"Cupertino"])


// MARK: - Checking API Availability

/*
 Swift has built-in support for checking API availability, which ensures that you don’t accidentally use APIs that are unavailable on a given deployment target.
 
 The compiler uses availability information in the SDK to verify that all of the APIs used in your code are available on the deployment target specified by your project. Swift reports an error at compile time if you try to use an API that isn’t available.
 
 You use an availability condition in an if or guard statement to conditionally execute a block of code, depending on whether the APIs you want to use are available at runtime. The compiler uses the information from the availability condition when it verifies that the APIs in that block of code are available.
 */

if #available(iOS 10, macOS 10.12, *) {
    print("AAA")
}
if #unavailable(iOS 8) {
    print("BBBB")
} else {
    print("GGGG")
}
