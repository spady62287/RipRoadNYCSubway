//
//  TestBaseClasses.swift
//  RipRoadNYCSubwayTests
//
//  Created by Daniel Spady on 2021-03-25.
//

import XCTest
@testable import RipRoadNYCSubway

class TestBaseClasses: XCTestCase {
    
    func testBaseResponse() {
        // Given
        struct MockResult: BaseJSONSerialization {
            let success: Bool
        }
                
        struct MockResponse: BaseResponse {
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
        
        // When
        let mockResponse = MockResponse(request: BaseRequest(), result: nil, task: nil, data: nil, response: nil, error: nil)
        
        // Then
        XCTAssertNotNil(mockResponse.request)
        XCTAssertNil(mockResponse.result)
        XCTAssertNil(mockResponse.task)
        XCTAssertNil(mockResponse.data)
        XCTAssertNil(mockResponse.response)
        XCTAssertNil(mockResponse.error)
    }
    
    func testBaseService() {
        // Given
        class MockRequest: BaseRequest {
            override var url: URL? {
                let urlString = BaseService.testLocalData
                return URL(fileURLWithPath: urlString)
            }
        }
        
        struct MockResult: BaseJSONSerialization {
            let success: Bool
            let result: Result?
            let columns: [Columns]?
        }
        
        struct Result: BaseJSONSerialization {
            let data: [[String]]
        }
                        
        struct Columns: BaseJSONSerialization {
            let index: Int?
            let name: String?
            let fieldName: String?
        }
        
        struct MockResponse: BaseResponse {
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
        
        let expectation = XCTestExpectation(description: "The Base Service should handle the Mock Request/Result/Response")
        let mockRequest = MockRequest()
        mockRequest.parameters?["timestamp"] = 1616694129000
        
        var task: URLSessionDataTask?
        
        // When
        task = BaseService.makePostRequest(with: mockRequest, completeOn: nil) { (data, response, error) in
                        
            let mockResponse = MockResponse(request: mockRequest,
                                            result: MockResult.fromJSON(data),
                                            task: task,
                                            data: data,
                                            response: response as? HTTPURLResponse,
                                            error: error)
                        
            XCTAssertNotNil(mockResponse.request)
            XCTAssertNotNil(mockResponse.result)
            XCTAssertNotNil(mockResponse.data)
            XCTAssertNotNil(mockResponse.task)
            XCTAssertNil(mockResponse.response)
            XCTAssertNil(mockResponse.error)
            
            expectation.fulfill()
        }

        task?.resume()
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
    
    func testBaseServiceHandlesErrors() {
        // Given
        class MockRequest: BaseRequest {
            override var url: URL? {
                let urlString = "https://www.badrequest.com"
                return URL(fileURLWithPath: urlString)
            }
        }

        struct MockResult: BaseJSONSerialization {
            let success: Bool
        }

        struct MockResponse: BaseResponse {
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
        
        enum FakeError: LocalizedError {
            case badRequest
        }
        
        let expectation = XCTestExpectation(description: "The Base Service should handle Errors in Mock Response")
        let mockRequest = MockRequest()
        mockRequest.parameters?["timestamp"] = 1616694129000

        var task: URLSessionDataTask?
        
        // When
        task = BaseService.makePostRequest(with: mockRequest, completeOn: nil) { (data, response, error) in
            
            let mockResponse = MockResponse(request: mockRequest,
                                            result: nil,
                                            task: task,
                                            data: data,
                                            response: response as? HTTPURLResponse,
                                            error: FakeError.badRequest)
            
            XCTAssertNotNil(mockResponse.request)
            XCTAssertNil(mockResponse.result)
            XCTAssertNil(mockResponse.data)
            XCTAssertNotNil(mockResponse.task)
            XCTAssertNil(mockResponse.response)
            XCTAssertNotNil(mockResponse.error)
            
            expectation.fulfill()
        }

        task?.resume()
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
}
