//
//  SubwayResponse.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-30.
//

import Foundation

struct SubwayResponse: BaseResponse {
    var request: BaseRequest?
    var task: URLSessionDataTask?
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
    var result: [String: Any]?
    
    public init() {
        self.request = Request()
        self.task = nil
        self.data = nil
        self.response = nil
        self.error = nil
        result = nil
    }
}
