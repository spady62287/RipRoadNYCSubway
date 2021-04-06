//
//  SubwayItemViewModel.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-04-06.
//

import Foundation

struct ColumnItemViewModel {
    let fieldName: String
    let object: Any
}

struct SubwayItemViewModel {
    var subwayDictionary: [String : ColumnItemViewModel] = [:]
}
