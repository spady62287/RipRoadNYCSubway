//
//  SubwayRequest.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-30.
//

import Foundation

class SubwayRequestLocal: BaseRequest {
    override var url: URL? {
        let urlString = BaseService.testLocalData
        return URL(fileURLWithPath: urlString)
    }
}
