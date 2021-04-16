//
//  QueueRingBuffer.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-04-15.
//

public struct QueueRingBuffer<T>: Queue {
    private var ringBuffer: RingBuffer<T>
    
    public init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    public var peek: T? {
        ringBuffer.first
    }
    
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
    
    public func valueAtIndex(_ index: Int) -> T? {
        return ringBuffer.atIndex(index)
    }
    
    public func count() -> Int {
        return ringBuffer.count()
    }
}

extension QueueRingBuffer: CustomStringConvertible {
    public var description: String {
        String(describing: ringBuffer)
    }
}
