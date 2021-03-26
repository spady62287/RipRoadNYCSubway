//
//  BaseCodable.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-25.
//

import Foundation

struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}

protocol BaseCodable: Codable {
    static var jsonDecoder: JSONDecoder { get }
    static func fromJSON<T: Decodable>(_ data: Data?) -> T?
}

extension BaseCodable {
    static var jsonDecoder: JSONDecoder {
        let result: JSONDecoder = JSONDecoder()
        
        result.dateDecodingStrategy = .formatted(DateFormatter.init())
        
        return result
    }
    static func fromJSON<T: Decodable>(_ data: Data?) -> T? {
        guard let data = data else {
            return nil
        }
        
        do {
            let throwables = try jsonDecoder.decode(Throwable<T>.self, from: data)
            return try throwables.result.get()
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        return nil
    }
}
