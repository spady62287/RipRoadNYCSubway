//
//  RingBuffer.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-04-15.
//

public struct RingBuffer<T> {
    
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public init (count: Int) {
        array = Array<T?>(repeating: nil, count: count)
    }
    
    public var first: T? {
        array[readIndex]
    }
    
    private var availableSpaceForReading: Int {
        writeIndex - readIndex
    }
    
    private var availableSpaceForWritting: Int {
        array.count - availableSpaceForReading
    }
    
    public var isEmpty: Bool {
        availableSpaceForReading == 0
    }
    
    public var isFull: Bool {
        availableSpaceForWritting == 0
    }
    
    public mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    public func atIndex(_ index: Int) -> T? {
        return array[index]
    }
    
    public func count() -> Int {
        return array.count
    }

}

extension RingBuffer: CustomStringConvertible {
    public var description: String {
        let values = (0..<availableSpaceForReading).map {
            String(describing: array[($0 + readIndex) % array.count]!)
        }
        return "[" + values.joined(separator: ", ") + "]"
    }
}
