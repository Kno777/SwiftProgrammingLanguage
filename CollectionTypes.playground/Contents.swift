// MARK: - Collection Types

/*
 Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values. Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.
 */

/*
 
 
 If you create an array, a set, or a dictionary, and assign it to a variable, the collection that’s created will be mutable. This means that you can change (or mutate) the collection after it’s created by adding, removing, or changing items in the collection. If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents can’t be changed.
 */


// MARK: - Arrays

/*
 An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.
 */

var someInts: [Int] = []

someInts.append(99)
someInts.append(44)
someInts.append(33)

someInts.append(contentsOf: [66,77,00])

someInts.first
someInts.last

someInts.capacity

let x = someInts.first(where: { $0 < 44 })
let y = someInts.last(where: { $0 > 22 })
x
y

someInts.startIndex
someInts.endIndex

someInts.description

someInts.contains([22,33])
someInts.contains(where: { $0 == 99 })

someInts.forEach { number in
        print(number)
}

someInts.distance(from: 2, to: someInts.count - 1)

someInts.insert(11, at: 0)
someInts.insert(contentsOf: [0,0,0,0], at: 3)

someInts.remove(at: 1)

someInts.removeAll(where: {$0 > 44 })

someInts.randomElement()


// MARK: - Sets

/*
 A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.
*/

/*
 Hash Values for Set Types
 A type must be hashable in order to be stored in a set—that is, the type must provide a way to compute a hash value for itself. A hash value is an Int value that’s the same for all objects that compare equally, such that if a == b, the hash value of a is equal to the hash value of b.
*/




var set: Set<Int> = []

set.count

set.insert(11)
set.insert(2)
set.insert(3)
set.insert(44)

set.isEmpty

set.contains(3)

set.contains(where: {$0 * 2 > 8})

set.remove(444)

set.first

set.sorted()

set.popFirst()


let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]

oddDigits.intersection(evenDigits)

oddDigits.symmetricDifference(evenDigits)

oddDigits.union(evenDigits)

oddDigits.subtracting(evenDigits)


// MARK: - Dictionaries

/*
 Dictionaries
 
 A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering. Each value is associated with a unique key, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary don’t have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.
*/

var myDict: [String : Int] = [:]

myDict["age"] = 20
myDict["weight"] = 86

myDict.count

myDict.keys

myDict.values

myDict.first

myDict.description

let m = myDict.startIndex

myDict.remove(at: m)

myDict.updateValue(444, forKey: "weight")

myDict
