//
//  BaseService.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-25.
//

import Foundation

class BaseService {
    
    static let sharedSession: URLSession = {
        
        let config = URLSessionConfiguration.default
        
        return URLSession(configuration: config)
    }()
    
    static var testLocalData: String {
        guard let endpoint = Bundle.main.path(forResource: "TestJsonExample", ofType: "json") else {
            return ""
        }
        
        return endpoint
    }
    
    static fileprivate let dispatchQueueQueue: DispatchQueue = DispatchQueue(label: "BaseService.dispatchQueueQueue", attributes: .concurrent)
    static fileprivate var _dispatchQueue: DispatchQueue = DispatchQueue.main
    
    static var dispatchQueue: DispatchQueue {
        get {
            var result: DispatchQueue!
            
            BaseService.dispatchQueueQueue.sync {
                result = BaseService._dispatchQueue
            }
            return result
        }
        set(newDispatchQueue) {
            BaseService.dispatchQueueQueue.async(flags: .barrier) {
                _dispatchQueue = newDispatchQueue
            }
        }
    }
    
    static func executeOnQueue(dispatchQueue: DispatchQueue?, completionHandler: @escaping () -> Swift.Void) {
        guard let dispatchQueue = dispatchQueue else {
            completionHandler()
            return
        }
        
        dispatchQueue.async {
            completionHandler()
        }
    }
}

extension BaseService {
    static func makeRequest<T: BaseRequest>(with baseRequest: T,
                                            urlRequest: URLRequest,
                                            completeOn dispatchQueue: DispatchQueue?,
                                            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask? {
        return BaseService.sharedSession.dataTask(with: urlRequest) { (data, response, error) in
            self.executeOnQueue(dispatchQueue: dispatchQueue) {
                completionHandler(data, response, error)
            }
        }
    }
    static func makePostRequest<T: BaseRequest>(with baseRequest: T,
                                                completeOn dispatchQueue: DispatchQueue?,
                                                completionHandler: @escaping (Data?, URLResponse?, Error?) ->
                                                Swift.Void) -> URLSessionDataTask? {
        guard let urlRequest = baseRequest.postRequest else {
            return nil
        }
        return makeRequest(with: baseRequest, urlRequest: urlRequest, completeOn: dispatchQueue, completionHandler: completionHandler)
    }
}
