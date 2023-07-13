
// MARK: - Remainder Operator (Module %)

9 % 4

// 9 = (4 * 2) + 1

-9 % 4

// -9 = (4 * -2) + -1

let three = 3

let minusThree = -three

minusThree

let plusThree = -minusThree
plusThree



/*
 You can compare two tuples if they have the same type and the same number of values. Tuples are compared from left to right, one value at a time, until the comparison finds two values that aren’t equal. Those two values are compared, and the result of that comparison determines the overall result of the tuple comparison. If all the elements are equal, then the tuples themselves are equal. For example:
 */

if (3, "name") < (2, "name"){
    print("2 name")
}
if (1, "name", 3) < (1, "name", 5) {
    //print("esim")
}
// good

// MARK: - Nil-Coalescing Operator

/*
 The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value, or returns a default value b if a is nil. The expression a is always of an optional type. The expression b must match the type that’s stored inside a.
 */

let defalutMyAppBarColor = "Red"

var userDefinedColorName: String?

let choosenColor = userDefinedColorName ?? defalutMyAppBarColor

choosenColor

// (??) === choosenColor = userDefinedColorName != nil ? userDefinedColorName! : defalutMyAppBarColor


// MARK: - Range Operators

/*
 Swift includes several range operators, which are shortcuts for expressing a range of values.
 
 Closed Range Operator
 The closed range operator (a...b) defines a range that runs from a to b, and includes the values a and b. The value of a must not be greater than b.
 */

//for index in 1...5 {
//    print("\(index) times 5 is \(index * 5)")
//}

// MARK: - Half-Open Range Operator

/*
 The half-open range operator (a..<b) defines a range that runs from a to b, but doesn’t include b. It’s said to be half-open because it contains its first value, but not its final value. As with the closed range operator, the value of a must not be greater than b. If the value of a is equal to b, then the resulting range will be empty.
 
 Half-open ranges are particularly useful when you work with zero- based lists such as arrays, where it’s useful to count up to (but not including) the length of the list:
 */

let names = ["Anna","Alex","Brian","Jack"]

let count = names.count

//for i in 0..<count{
//    print("Person \(i + 1) is called \(names[i])")
//}


// MARK: - One-Sided Ranges

/*
 The closed range operator has an alternative form for ranges that continue as far as possible in one direction—for example, a range that includes all the elements of an array from index 2 to the end of the array. In these cases, you can omit the value from one side of the range operator. This kind of range is called a one-sided range because the operator has a value on only one side. For example:
 */

//for name in names[2...]{
//    print(name)
//}

//for name in names[...2]{
//    print(name)
//}

//for name in names[..<2]{
//    print(name)
//}

let range = ...5
//range.contains(0)
//range.contains(2)
//range.contains(3)
//range.contains(4)
//range.contains(5)
//range.contains(6)

