//
//  main.swift
//  TriePoc
//
//  Created by Abhishek Kumar on 18/01/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

print("Hello, World!")
//Trie implementation
let trie = Trie()
trie.insert(word: "cute")
trie.insert(word: "cu")
trie.insert(word: "c")
trie.insert(word: "p")
print(trie.contains(word: "c"))

infix operator =~
precedencegroup MultiplicationPrecedence {
  associativity: left
  higherThan: AdditionPrecedence
}

func apply(input : [Int] , transforms : (Int , Int) -> Int) -> [Int] {
    var result : [Int] = []
    for value in input {
        result.append(transforms(value , value * 6))
    }
    return result
}
// operator over loading
func =~(lhs : [Int] , rhs : [Int]) -> [Int] {
    let result1 = apply(input: lhs) { $0 * $1}
    let result2 = apply(input: rhs) { $0 + $1}
    return result1 + result2
}

let result = [40, 90 , 80, 30 , 89 ] =~ [50 , 90 , 78 , 67]
print(result)

let array = ["abhishek", "aditi" , "shikar", "Neha" , "akansha" , "divya", "mahendra"]
extension String {
    func filterTheValue(with predicate : NSPredicate) -> Bool{
        return predicate.evaluate(with: self)
    }
}
// custom filter implementation
func customFilter(input : [String] , transform : (String) -> (String?)) -> [String] {
    var result : [String] = []
    for value in input {
        if let newValue = transform(value) {
            result.append(newValue)
        }
    }
    return result
}

func search(searchText : String , array : [String]) -> [String] {
    let predicate = NSPredicate(format: "SELF BEGINSWITH[cd] %@", searchText)
//    let result = array.filter {
//        $0.filterTheValue(with: predicate)
//    }
    let result = customFilter(input: array) { $0.filterTheValue(with: predicate) ? $0 : nil }
    return result
}



print(search(searchText: "abh", array: array))

// Generics

func searchForString<T : Equatable>(input : T , from genericArray : [T]) -> Int?{
    for (index , elemet) in genericArray.enumerated() {
        if elemet == input {
            return index
        }
    }
    return nil
}



print("Generic result :- \(searchForString(input: "abhishek", from: ["mukul", "mahendra" , "abhishek" , "shikar" , "jeevan"])!)")


protocol Container {
    associatedtype Item : Equatable
    mutating func append(_ item : Item)
    var count : Int {get}
    subscript(i : Int) -> Item {get}
}

struct Stack<Element : Equatable>: Container {
    
    
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
protocol SuffixableContainer : Container {
    associatedtype Suffix : SuffixableContainer where Suffix.Item == Item
    func suffix(_ size : Int) -> Suffix
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count - size)..<count{
            result.append(self[index])
        }
        return result
    }
}

var stackInts = Stack<Int>()
stackInts.append(10)
stackInts.append(20)
stackInts.append(30)
let suffix = stackInts.suffix(2)
print(suffix)
