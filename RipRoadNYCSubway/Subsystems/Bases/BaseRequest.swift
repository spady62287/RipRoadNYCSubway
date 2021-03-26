//
//  BaseRequest.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-25.
//

import Foundation

class BaseRequest {
    
    var parameters: [String: Any]?
    
    var url: URL? {
        return nil
    }
    
    var request: URLRequest? {
        if let url = url {
            let request = URLRequest(url: url)
            
            return request
        }
        return nil
    }
    
    public var postRequest: URLRequest? {
        if var request = request {
            request.httpMethod = "POST"
            
            if let parameters = parameters {
                do {
                    let options = JSONSerialization.WritingOptions()
                    let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
                    
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    request.httpBody = data
                } catch {
                    print("BaseRequest.postRequest Error: \(error)")
                }
            }
            
            return request as URLRequest
        }
        
        return nil
    }
}
