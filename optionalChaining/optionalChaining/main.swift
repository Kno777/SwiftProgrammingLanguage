
// MARK: - Optional Chaining

/*
 Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil. Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.
 
 NOTE:
 Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checked for success or failure.
*/


/*
 Optional Chaining as an Alternative to Forced Unwrapping:
 
 You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil. This is very similar to placing an exclamation point (!) after an optional value to force the unwrapping of its value. The main difference is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.
 
 To reflect the fact that optional chaining can be called on a nil value, the result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a non-optional value. You can use this optional return value to check whether the optional chaining call was successful (the returned optional contains a value), or didn’t succeed due to a nil value in the chain (the returned optional value is nil).
  
 Specifically, the result of an optional chaining call is of the same type as the expected return value, but wrapped in an optional. A property that normally returns an Int will return an Int? when accessed through optional chaining.
 
 The next several code snippets demonstrate how optional chaining differs from forced unwrapping and enables you to check for success.
 First, two classes called Person and Residence are defined:
 */

class Person1{
    var residence: Residence?
}

//class Residence {
//    var numberOfRooms = 1
//}

// let john = Person()
//
//print(john.residence?.numberOfRooms as? Int)
//
//if let roomCount = john.residence?.numberOfRooms {
//    print("John's residence has \(roomCount) room(s).")
//} else{
//    print("null")
//}
//
//john.residence = Residence()
//
//if let roomCount = john.residence?.numberOfRooms {
//    print("John's residence has \(roomCount) room(s).")
//} else{
//    print("null")
//}

class Room{
    let name: String
    init(name: String){
        self.name = name
    }
}

class Address{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let
            street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class Residence{
    var address: Address?
    var rooms: [Room] = []
    
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
}

let john=Person1()

if let roomCount = john.residence?.numberOfRooms{
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Null")
}

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

//let someAddress = Address()
//someAddress.buildingNumber="29"
//someAddress.street="AcaciaRoad"

john.residence?.address = createAddress() // -> never called because residence is nil.

// MARK: - Error Handling

/*
 Error handling is the process of responding to and recovering from error conditions in your program. Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.
 
 Some operations aren’t guaranteed to always complete execution or produce a useful output. Optionals are used to represent the absence of a value, but when an operation fails, it’s often useful to understand what caused the failure, so that your code can respond accordingly.
 
 As an example, consider the task of reading and processing data from a file on disk. There are a number of ways this task can fail, including the file not existing at the specified path, the file not having read permissions, or the file not being encoded in a compatible format. Distinguishing among these different situations allows a program to resolve some errors and to communicate to the user any errors it can’t resolve.
 
 NOTE:
 Error handling in Swift interoperates with error handling patterns that use the NSError class in Cocoa and Objective-C. For more information about this class, see Handling Cocoa Errors in Swift.
*/

/// Representing and Throwing Errors
/*
 In Swift, errors are represented by values of types that conform to the Error protocol. This empty protocol indicates that a type can be used for error handling.
  
 Swift enumerations are particularly well suited to modeling a group of related error conditions, with associated values allowing for additional information about the nature of an error to be communicated. For example, here’s how you might represent the error conditions of operating a vending machine inside a game:
*/

enum VendingMachineError:Error{
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

/// Handling Errors
/*
 When an error is thrown, some surrounding piece of code must be responsible for handling the error—for example, by correcting the problem, trying an alternative approach, or informing the user of the failure.
 
 There are four ways to handle errors in Swift. You can propagate the error from a function to the code that calls that function, handle the error using a do-catch statement, handle the error as an optional value, or assert that the error will not occur. Each approach is described in a section below.
 
 When a function throws an error, it changes the flow of your program, so it’s important that you can quickly identify places in your code that can throw errors. To identify these places in your code, write the try keyword—or the try? or try! variation—before a piece of code that calls a function, method, or initializer that can throw an error. These keywords are described in the sections below.
*/


enum LoginError: Error {
    case emptyEmail
    case emptyPassword
    case emptyNumber
}

class Person {
    var email: String
    var password: String
    var number: String
    
    var personInfo: String {
        return "Email: \(email), Password: \(password), Number: \(number)"
    }
    
    init(email: String, password: String, number: String) {
        self.email = email
        self.password = password
        self.number = number
    }
}

func login(email:String, password:String, number: String) throws -> Person {
    if email.isEmpty {
        throw LoginError.emptyEmail
    }
    
    if password.isEmpty {
        throw LoginError.emptyPassword
    }
    
    if number.isEmpty {
        throw LoginError.emptyNumber
    }
    
    return Person(email: email , password: password, number: number)
}

do {
    let person = try login(email: "ddd", password: "ddkdk", number: "erre")
    print(person.personInfo)
} catch {
    print("You have this error \(error)")
}


// MARK: - Converting Errors to Optional Values

/*
 You use try? to handle an error by converting it to an optional value. If an error is thrown while evaluating the try? expression, the value of the expression is nil. For example, in the following code x and y have the same value and behavior:
*/

func someThrowingFunction() throws -> Int{
    // ...
    return 0
}

let x = try? someThrowingFunction()
let y: Int?

do{
    y = try someThrowingFunction()
} catch {
    y = nil
}

//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() {
//        return data
//    }
//
//    if let data = try? fetchDataFromServer() {
//        return data
//    }
//
//    return nil
//} -> good example


// MARK: - Specifying Cleanup Actions

/*
 You use a defer statement to execute a set of statements just before code execution leaves the current block of code. This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as return or break. For example, you can use a defer statement to ensure that file descriptors are closed and manually allocated memory is freed.
 
 A defer statement defers execution until the current scope is exited. This statement consists of the defer keyword and the statements to be executed later. The deferred statements may not contain any code that would transfer control out of the statements, such as a break or a return statement, or by throwing an error. Deferred actions are executed in the reverse of the order that they’re written in your source code. That is, the code in the first defer statement executes last, the code in the second defer statement executes second to last, and so on. The last defer statement in source code order executes first.
*/


// Work with the file.
//func processFile(filename:String) throws {
//    if exists(filename) {
//        let file = open(filename)
//    }
//    defer {
//        close(file)
//    }
//    while let line = try file.readline() {
//        // close(file) is called here, at the end of the scope.
//    }
//}



