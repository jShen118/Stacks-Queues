//
//  main.swift
//  stacks and queues
//
//  Created by Joshua Shen on 9/29/18.
//  Copyright © 2018 Joshua Shen. All rights reserved.
//

import Foundation

import Foundation

struct Stack<Element>: CustomStringConvertible {
    var stack: [Element?]
    var pushIndex = 0
    init(size: Int) {
        stack = Array(repeating: nil, count: size)
    }
    
    func isEmpty()->Bool {
        if pushIndex == 0 {return true}
        return false
    }
    func isFull()->Bool {
        if pushIndex == stack.count {return true}
        return false
    }
    
    mutating func push(_ element: Element) {
        if self.isFull() == true {
            print("Cannot push \(element), stack is full")
            return
        }
        stack[pushIndex] = Optional(element)
        pushIndex += 1
    }
    mutating func pop()-> Element? {
        var result: Element? = nil
        if self.isEmpty() == true {
            print("cannot pop, stack is empty")
            return result
        }
        result = stack[pushIndex - 1]
        //stack[pushIndex - 1] = nil
        pushIndex = pushIndex - 1
        return result
    }
    
    var description: String {
        var result = ""
        for i in 0 ..< pushIndex {
            result += "\(stack[i]!) "
        }
        return result
    }
}


struct Queue<Element>: CustomStringConvertible {
    var queue: [Element?]
    var nqIndex = 0
    var dqIndex = 0
    init(size: Int) {
        queue = Array(repeating: nil, count: size)
    }
    
    func isEmpty()-> Bool {
        if nqIndex == dqIndex {return true}
        return false
    }
    func isFull()-> Bool {
        if dqIndex == (nqIndex - queue.count) {return true}
        return false
    }
    
    mutating func enqueue(_ element: Element) {
        if self.isFull() == true {
            print("Can't enqueue \(element), the queue is full")
            return
        }
        queue[nqIndex % queue.count] = element
        nqIndex += 1
    }
    mutating func dequeue()-> Element? {
        var result: Element? = nil
        if self.isEmpty() == true {
            print("Can't dequeue, the queue is empty")
            return result
        }
        result = queue[dqIndex % queue.count]
        //queue[dqIndex % 5] = nil
        dqIndex += 1
        return result
    }
    
    var description: String {
        //var result = ""
        //for i in dqIndex ..< nqIndex {
        //result += "\(queue[i % queue.count]!) "
        //}
        return "\(queue)"
    }
    
    func map<U>(_ f: (Element)-> U)-> Queue<U> {
        var mappedItems = Queue<U>(size: queue.count)
        for i in dqIndex ..< nqIndex {
            mappedItems.enqueue(f(queue[i % queue.count]!))
        }
        return mappedItems
    }
}

var x = Queue<Int>(size: 3)
print(x)
x.dequeue()
x.enqueue(5)
x.enqueue(6)
x.enqueue(7)
x.enqueue(5)
print(x)
print(x.dequeue())
x.enqueue(900)
print(x)
print(x.map {2 * $0})
print(x)

