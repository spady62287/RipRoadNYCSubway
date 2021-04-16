//
//  Queue.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-04-15.
//

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}
