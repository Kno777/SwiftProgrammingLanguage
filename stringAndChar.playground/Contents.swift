
// MARK: - String and Character

/*
 A string is a series of characters, such as "hello, world" or "albatross". Swift strings are represented by the String type. The contents of a String can be accessed in various ways, including as a collection of Character values.
 */

let someString = "Some string literal value"
someString

let quotation = """
    The White Rabbit put on his spectacles. "Where shall
    I begin,
    pleaseyourMajesty?"heasked.
    
    "Beginatthebeginning,"theKingsaidgravely,"and
    go on
    tillyoucometotheend;thenstop."
"""
quotation

// MARK: - Special Characters in String Literals

/*
 String literals can include the following special characters:
 
 The escaped special characters \0 (null character), \\ (backslash), \t (horizontal tab), \n (line feed), \r (carriage return), \" (double quotation mark) and \' (single quotation mark)
  
 An arbitrary Unicode scalar value, written as \u{n}, where n is a 1–8 digit hexadecimal number (Unicode is discussed in Unicode below)
 */


var myStr: String = "Hello"

myStr.append(" Haykko")


var myChar: Character = "e"
myChar

print(#"6 times 7 is \#(6*7)."#)



