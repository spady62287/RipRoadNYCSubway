//
//  SubwayUtility.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-30.
//

import Foundation

class SubwayUtility: BaseService {
    @discardableResult static public func subwayJSONObject(_ request: BaseRequest = BaseRequest(), dispatchQueue: DispatchQueue? = BaseService.dispatchQueue, completionHandler: @escaping (SubwayResponse) -> Void) -> URLSessionDataTask? {
        
        var task: URLSessionDataTask?
        
        task = BaseService.makePostRequest(with: request, completeOn: nil) { (data, response, error) in
                        
            let response = SubwayResponse(request: request,
                                            result: SubwayResult.fromJSON(data),
                                            task: task,
                                            data: data,
                                            response: response as? HTTPURLResponse,
                                            error: error)
            
            completionHandler(response)
        }
        
        task?.resume()

        return task
    }
}
