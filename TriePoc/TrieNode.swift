//
//  TrieNode.swift
//  TriePoc
//
//  Created by Abhishek Kumar on 18/01/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

class TrieNode<T : Hashable> {
    var value : T?
    weak var parent : TrieNode?
    var childern : [T : TrieNode] = [:]
    var isTerminating = false
    
    init(value : T? = nil , parent : TrieNode? = nil) {
        self.parent = parent
        self.value = value
    }
    
    func add(child : T) {
        guard childern[child] == nil else {
            return
        }
        childern[child] = TrieNode(value: child, parent: self)
    }
}

class Trie {
    typealias  Node = TrieNode<Character>
    var root : Node
    init() {
        self.root = Node()
    }
    
    func insert(word : String) {
        var currentNode = root
        let characterArray = Array(word.lowercased())
        var currentIndex = 0
        while currentIndex < characterArray.count {
            let charcter = characterArray[currentIndex]
            if let child = currentNode.childern[charcter] {
                currentNode = child
            }else {
                currentNode.add(child: charcter)
                currentNode = currentNode.childern[charcter]!
            }
            currentIndex += 1
        }
        
        if currentIndex == characterArray.count {
            currentNode.isTerminating = true
        }
    }
}

extension Trie {
    func contains(word : String) -> Bool {
        guard !word.isEmpty else {return false}
        var currentNode = root
        let character = Array(word.lowercased())
        var currentIndex = 0
        while currentIndex < character.count , let child = currentNode.childern[character[currentIndex]] {
            currentIndex += 1
            currentNode = child
        }
        if currentIndex == character.count && currentNode.isTerminating == true {
            return true
        }else {
            return false
        }
    }
}


