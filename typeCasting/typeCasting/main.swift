
// MARK: - Type Casting

/*
 Type casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.
 
 Type casting in Swift is implemented with the is and as operators. These two operators provide a simple and expressive way to check the type of a value or cast a value to a different type.
 
 You can also use type casting to check whether a type conforms to a protocol, as described in Checking for Protocol Conformance.
*/

class MediaItem{
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Song: MediaItem{
    var artist: String
    init(name: String, artist: String) {
            self.artist = artist
            super.init(name: name)
    }
}

class Movie: MediaItem{
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// MARK: - Checking Type

/*
 Use the type check operator (is) to check whether an instance is of a certain subclass type. The type check operator returns true if the instance is of that subclass type and false if it’s not.

 The example below defines two variables, movieCount and songCount, which count the number of Movie and Song instances in the library array:
*/


var movieCount=0
var songCount=0
for item in library{
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print(movieCount)
print(songCount)

// MARK: - Downcasting
/*
 A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!).
 
 Because downcasting can fail, the type cast operator comes in two different forms. The conditional form, as?, returns an optional value of the type you are trying to downcast to. The forced form, as!, attempts the downcast and force-unwraps the result as a single compound action.
 
 Use the conditional form of the type cast operator (as?) when you aren’t sure if the downcast will succeed. This form of the operator will always return an optional value, and the value will be nil if the downcast was not possible. This enables you to check for a successful downcast.
 
 Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
 
 The example below iterates over each MediaItem in library, and prints an appropriate description for each item. To do this, it needs to access each item as a true Movie or Song, and not just as a MediaItem. This is necessary in order for it to be able to access the director or artist property of a Movie or Song for use in the description.
 
 In this example, each item in the array might be a Movie, or it might be a Song. You don’t know in advance which actual class to use for each item, and so it’s appropriate to use the conditional form of the type cast operator (as?) to check the downcast each time through the loop:
*/

/*
 NOTE:
 Casting doesn’t actually modify the instance or change its values. The underlying instance remains the same; it’s simply treated and accessed as an instance of the type to which it has been cast.
*/

for item in library {
if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}


// MARK: - Type Casting for Any and AnyObject

/*
 Swift provides two special types for working with nonspecific types: Any can represent an instance of any type at all, including
 function types.
 
 AnyObject can represent an instance of any class type.
 
 Use Any and AnyObject only when you explicitly need the behavior and capabilities they provide. It’s always better to be specific about the types you expect to work with in your code.
 
 Here’s an example of using Any to work with a mix of different types, including function types and nonclass types. The example creates an array called things, which can store values of type Any:
*/

var things: [Any] = []
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0,5.0))
things.append(Movie(name:"Ghostbusters",director: "Ivan Reitman"))
things.append({(name:String) -> String in "Hello, \(name)" })

for thing in things{
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}


// MARK: - Nested Types

/*
 Enumerations are often created to support a specific class or structure’s functionality. Similarly, it can be convenient to define utility classes and structures purely for use within the context of a more complex type. To accomplish this, Swift enables you to define nested types, whereby you nest supporting enumerations, classes, and structures within the definition of the type they support.
 
 To nest a type within another type, write its definition within the outer braces of the type it supports. Types can be nested to as many levels as are required.
*/
            
class Outer {
    var name: String = "outer"
    
    class Nested {
        var x: String = "nested"
    }
}

var outer = Outer.Nested()
print(outer.x)

// All nested enums, structers, or classes are beacome static and we can have access only use Class Type but not instance type.

