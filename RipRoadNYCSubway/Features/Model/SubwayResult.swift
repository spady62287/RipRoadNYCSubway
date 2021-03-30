//
//  SubwayResult.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-30.
//

import Foundation

enum SubwayJSONKeys: String {
    case success, result, columns, data, fieldName, index, name
}

struct SubwayResult: BaseJSONSerialization {
    let success: Bool
    let result: SubwayData
    let columns: [Column]
}

struct SubwayData {
    var data: [[Any]]
}

struct Column {
    let index: String
    let name: String
    let fieldName: String
}

extension SubwayResult {
    init?(json: [String: Any]) {
        
        guard let success = json[SubwayJSONKeys.success.rawValue] as? Bool else {
            return nil
        }
        
        self.success = success
        
        guard let resultDictionary = json[SubwayJSONKeys.result.rawValue] as? [String: Any],
              let dataArray = resultDictionary[SubwayJSONKeys.data.rawValue] as? [[Any]] else {
                return nil
        }
        
        self.result = SubwayData(data: dataArray)
        
        guard let columnArray = resultDictionary[SubwayJSONKeys.columns.rawValue] as? [Any] else {
            return nil
        }
        
        var coloumsArrayPlaceholder: [Column] = [Column]()
        
        for columnObject in columnArray {
            if let object = columnObject as? [String: Any] {
                if let fieldName = object[SubwayJSONKeys.fieldName.rawValue] as? String,
                   let index = object[SubwayJSONKeys.index.rawValue] as? String,
                   let name = object[SubwayJSONKeys.name.rawValue] as? String {
                    coloumsArrayPlaceholder.append(Column(index: index, name: name, fieldName: fieldName))
                }
            }
        }
        
        self.columns = coloumsArrayPlaceholder
    }
}
