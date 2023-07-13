//
//  main.swift
//  concurrency
//
//  Created by Kno Harutyunyan on 07.07.23.
//

import Foundation

// MARK: - Concurrency

/*
 Swift has built-in support for writing asynchronous and parallel code in a structured way. Asynchronous code can be suspended and resumed later, although only one piece of the program executes at a time. Suspending and resuming code in your program lets it continue to make progress on short-term operations like updating its UI while continuing to work on long-running operations like fetching data over the network or parsing files. Parallel code means multiple pieces of code run simultaneously—for example, a computer with a four-core processor can run four pieces of code at the same time, with each core carrying out one of the tasks. A program that uses parallel and asynchronous code carries out multiple operations at a time; it suspends operations that are waiting for an external system, and makes it easier to write this code in a memory-safe way.
 
 The additional scheduling flexibility from parallel or asynchronous code also comes with a cost of increased complexity. Swift lets you express your intent in a way that enables some compile-time checking—for example, you can use actors to safely access mutable state. However, adding concurrency to slow or buggy code isn’t a guarantee that it will become fast or correct. In fact, adding concurrency might even make your code harder to debug. However, using Swift’s language-level support for concurrency in code that needs to be concurrent means Swift can help you catch problems at compile time.
 
 The rest of this chapter uses the term concurrency to refer to this common combination of asynchronous and parallel code.
 
 NOTE:
 If you’ve written concurrent code before, you might be used to working with threads. The concurrency model in Swift is built on top of threads, but you don’t interact with them directly. An asynchronous function in Swift can give up the thread that it’s running on, which lets another asynchronous function run on that thread while the first function is blocked. When an asynchronous function resumes, Swift doesn’t make any guarantee about which thread that function will run on.
*/

// MARK: - Defining and Calling Asynchronous Functions

/*
 An asynchronous function or asynchronous method is a special kind of function or method that can be suspended while it’s partway through execution. This is in contrast to ordinary, synchronous functions and methods, which either run to completion, throw an error, or never return. An asynchronous function or method still does one of those three things, but it can also pause in the middle when it’s waiting for something. Inside the body of an asynchronous function or method, you mark each of these places where execution can be suspended.
*/

/*
 To indicate that a function or method is asynchronous, you write the async keyword in its declaration after its parameters, similar to how you use throws to mark a throwing function. If the function or method returns a value, you write async before the return arrow (->). For example, here’s how you might fetch the names of photos in a gallery:
*/

func listPhotos(inGallery name: String) async throws -> [String] {
    
    let result = [name, name] // ... some asynchronous networking
    try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    return result
}

//print(try await listPhotos(inGallery: "IMG456"))


// MARK: - Calling Asynchronous Functions in Parallel

/*
 Calling an asynchronous function with await runs only one piece of code at a time. While the asynchronous code is running, the caller waits for that code to finish before moving on to run the next line of code. For example, to fetch the first three photos from a gallery, you could await three calls to the downloadPhoto(named:) function as follows:
 */

func asyncFunction(name: String) async -> String{
    print(name)
    return name
}




// ##################################################################
/*
 This approach has an important drawback: Although the download is asynchronous and lets other work happen while it progresses, only one call to downloadPhoto(named:) runs at a time. Each photo downloads completely before the next one starts downloading. However, there’s no need for these operations to wait—each photo can download independently, or even at the same time.
*/
 let first =  await asyncFunction(name: "first")

 let seconde = await  asyncFunction(name: "seconde")

 let third =  await asyncFunction(name: "third")
// ##################################################################



// ##################################################################
/*
 To call an asynchronous function and let it run in parallel with code around it, write async in front of let when you define a constant, and then write await each time you use the constant.
 */

async let firstParallel =  asyncFunction(name: "firstParallel")

async let secondeParallel =  asyncFunction(name: "secondeParallel")

async let thirdParallel =  asyncFunction(name: "thirdParallel")
// ##################################################################


// MARK: - Tasks and Task Groups

/*
 A task is a unit of work that can be run asynchronously as part of your program. All asynchronous code runs as part of some task. The async-let syntax described in the previous section creates a child task for you. You can also create a task group and add child tasks to that group, which gives you more control over priority and cancellation, and lets you create a dynamic number of tasks.
 
 Tasks are arranged in a hierarchy. Each task in a task group has the same parent task, and each task can have child tasks. Because of the explicit relationship between tasks and task groups, this approach is called structured concurrency. Although you take on some of the responsibility for correctness, the explicit parent-child relationships between tasks lets Swift handle some behaviors like propagating cancellation for you, and lets Swift detect some errors at compile time.
*/


//await withTaskGroup(of: Data.self){ taskGroup in
//    let photoNames = await listPhotos(inGallery: "Summer Vacation")
//    for name in photoNames {
//        taskGroup.addTask { await
//            downloadPhoto(named: name) }
//    }
//}


// MARK: - Unstructured Concurrency

/*
 In addition to the structured approaches to concurrency described in the previous sections, Swift also supports unstructured concurrency. Unlike tasks that are part of a task group, an unstructured task doesn’t have a parent task. You have complete flexibility to manage unstructured tasks in whatever way your program needs, but you’re also completely responsible for their correctness. To create an unstructured task that runs on the current actor, call the Task.init(priority:operation:) initializer. To create an unstructured task that’s not part of the current actor, known more specifically as a detached task, call the Task.detached(priority:operation:) class method. Both of these operations return a task that you can interact with—for example, to wait for its result or to cancel it.
*/

let newPhoto = "Spring Adventures" //...some photo data...
let handle=Task{
    return await asyncFunction(name: newPhoto)
}
let result=await handle.value
print(result)


// MARK: - Actors
/*
 You can use tasks to break up your program into isolated, concurrent pieces. Tasks are isolated from each other, which is what makes it safe for them to run at the same time, but sometimes you need to share some information between tasks. Actors let you safely share information between concurrent code.
 
 Like classes, actors are reference types, so the comparison of value types and reference types in Classes Are Reference Types applies to actors as well as classes. Unlike classes, actors allow only one task to access their mutable state at a time, which makes it safe for code in multiple tasks to interact with the same instance of an actor. For example, here’s an actor that records temperatures:
*/


actor TemperatureLogger{
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
