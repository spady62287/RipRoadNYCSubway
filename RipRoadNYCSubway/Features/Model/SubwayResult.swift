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
    let index: Int
    let name: String
    let fieldName: String
}

struct ColumnItemViewModel {
    let fieldName: String
    let object: Any
}

struct SubwayItemViewModel {
    var subwayDictionary: [String : ColumnItemViewModel] = [:]
}

struct SubwayListViewModel {
    var isSelected: Bool = false
    var itemValue: String = ""
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
                   let index = object[SubwayJSONKeys.index.rawValue] as? Int,
                   let name = object[SubwayJSONKeys.name.rawValue] as? String {
                    coloumsArrayPlaceholder.append(Column(index: index, name: name, fieldName: fieldName))
                }
            }
        }
        
        self.columns = coloumsArrayPlaceholder
    }
}

extension SubwayResult {
    func didRequestSucceed() -> Bool {
        return self.success
    }
    
    func numberOfItems(with subwayLine: String?) -> Int {
        return filterList(with: subwayLine).count
    }
    
    func itemFrom(indexPath: IndexPath, with subwayLine: String?) -> SubwayItemViewModel? {
        guard self.columns.count == 13 else {
            return nil
        }
        
        guard indexPath.row < self.result.data.count && indexPath.row >= 0 else {
            return nil
        }
        
        let list = filterList(with: subwayLine)
        let item = list[indexPath.row]
        
        var subwayItem = SubwayItemViewModel()
        
        for column in self.columns {
            subwayItem.subwayDictionary[column.name] = ColumnItemViewModel(fieldName: column.fieldName, object: item[column.index])
        }
        
        return subwayItem
    }
    
    func listOfSubwayLines() -> LinkedList<SubwayListViewModel> {
        var list = Set<String>()
        
        for item in self.result.data {
            if let lineArray = item[12] as? String {
                let characters = Array(lineArray)
                for character in characters {
                    list.insert("\(character)")
                }
            }
        }
        
        list.remove(" ")
        list.remove("-")
        
        var listViewModel = LinkedList<SubwayListViewModel>()
        for item in list {
            listViewModel.push(SubwayListViewModel(itemValue: item))
        }
        
        return listViewModel
    }
    
    func filterList(with subwayLine: String?) -> [[Any]] {
        
        guard let subwayLine = subwayLine else {
            return self.result.data
        }
        
        var newList: [[Any]] = []
        
        for item in self.result.data {
            if let lineArray = item[12] as? String {
                let characters = Array(lineArray)
                for character in characters {
                    if subwayLine == "\(character)" {
                        newList.append(item)
                        break
                    }
                }
            }
        }
        
        return newList
    }
}
