//
//  BaseJSONSerialization.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-30.
//

import Foundation

protocol BaseJSONSerialization {
    static func fromJSON(_ data: Data?) -> [String: Any]?
}

extension BaseJSONSerialization {
    static func fromJSON(_ data: Data?) -> [String: Any]? {
        guard let data = data else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
    }
}
