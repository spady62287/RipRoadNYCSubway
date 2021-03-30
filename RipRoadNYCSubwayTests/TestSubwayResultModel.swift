//
//  TestSubwayResultModel.swift
//  RipRoadNYCSubwayTests
//
//  Created by Daniel Spady on 2021-03-30.
//

import XCTest
@testable import RipRoadNYCSubway

class TestSubwayResultModel: XCTestCase {
    
    func testSubwayModel() {
        // Given
        let expectation = XCTestExpectation(description: "Subway Result should initialize with JSON Data")
        let mockRequest = SubwayRequestLocal()
        mockRequest.parameters?["timestamp"] = 1616694129000
        
        // When
        SubwayUtility.subwayJSONObject(mockRequest) { response in
            if let result = response.result {
                let subway = SubwayResult(json: result)
                XCTAssertNotNil(subway?.success)
                XCTAssertNotNil(subway?.columns)
                XCTAssertNotNil(subway?.result.data)

                expectation.fulfill()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
}
