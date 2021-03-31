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
    
    func testSubwyModelIsSuccessful() {
        // Given
        let expectation = XCTestExpectation(description: "Subway Result should return True for success")
        var subwayResult: SubwayResult? = nil
        let mockRequest = SubwayRequestLocal()
        mockRequest.parameters?["timestamp"] = 1616694129000
        
        // When
        SubwayUtility.subwayJSONObject(mockRequest) { response in
            if let result = response.result {
                if let subway = SubwayResult(json: result) {
                    
                    subwayResult = subway
                    
                    if let subwayResult = subwayResult {
                        XCTAssertTrue(subwayResult.didRequestSucceed())
                        expectation.fulfill()
                    }
                }
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
    
    func testSubwayModelNumberOfItems() {
        // Given
        let expectation = XCTestExpectation(description: "Subway Result should have 1928 items")
        var subwayResult: SubwayResult? = nil
        let mockRequest = SubwayRequestLocal()
        mockRequest.parameters?["timestamp"] = 1616694129000
        
        // When
        SubwayUtility.subwayJSONObject(mockRequest) { response in
            if let result = response.result {
                if let subway = SubwayResult(json: result) {
                    
                    subwayResult = subway
                    
                    if let subwayResult = subwayResult {
                        XCTAssertEqual(subwayResult.numberOfItems(with: nil), 1928)
                        expectation.fulfill()
                    }
                }
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
    
    func testSubwayViewModelItem() {
        // Given
        let expectation = XCTestExpectation(description: "Subway View Model shoud return item from index path")
        var subwayResult: SubwayResult? = nil
        let mockRequest = SubwayRequestLocal()
        mockRequest.parameters?["timestamp"] = 1616694129000
        
        // When
        SubwayUtility.subwayJSONObject(mockRequest) { response in
            if let result = response.result {
                if let subway = SubwayResult(json: result) {
                    
                    subwayResult = subway
                    
                    if let subwayResult = subwayResult {
                        let indexPath = IndexPath.init(row: 25, section: 0)
                        let subwayItemViewModel = subwayResult.itemFrom(indexPath: indexPath, with: nil)
                        if let subwayItemViewModel = subwayItemViewModel {
                            
                            let updatedMetaViewModel = subwayItemViewModel.subwayDictionary["updated_meta"]
                            let metaViewModel = subwayItemViewModel.subwayDictionary["meta"]
                            let objectIdViewModel = subwayItemViewModel.subwayDictionary["OBJECTID"]
                            let urlViewModel = subwayItemViewModel.subwayDictionary["URL"]
                            let positionViewModel = subwayItemViewModel.subwayDictionary["position"]
                            let theGeomViewModel = subwayItemViewModel.subwayDictionary["the_geom"]
                            let createdMetaViewModel = subwayItemViewModel.subwayDictionary["created_meta"]
                            let lineViewModel = subwayItemViewModel.subwayDictionary["LINE"]
                            let nameViewModel = subwayItemViewModel.subwayDictionary["NAME"]
                            let idViewModel = subwayItemViewModel.subwayDictionary["id"]
                            let sidViewModel = subwayItemViewModel.subwayDictionary["sid"]
                            let createdAtViewModel = subwayItemViewModel.subwayDictionary["created_at"]
                            
                            XCTAssertEqual(updatedMetaViewModel?.fieldName, ":updated_meta")
                            XCTAssertEqual(metaViewModel?.fieldName, ":meta")
                            XCTAssertEqual(objectIdViewModel?.fieldName, "objectid")
                            XCTAssertEqual(urlViewModel?.fieldName, "url")
                            XCTAssertEqual(positionViewModel?.fieldName, ":position")
                            XCTAssertEqual(theGeomViewModel?.fieldName, "the_geom")
                            XCTAssertEqual(lineViewModel?.fieldName, "line")
                            XCTAssertEqual(nameViewModel?.fieldName, "name")
                            XCTAssertEqual(createdMetaViewModel?.fieldName, ":created_meta")
                            XCTAssertEqual(idViewModel?.fieldName, ":id")
                            XCTAssertEqual(sidViewModel?.fieldName, ":sid")
                            XCTAssertEqual(createdAtViewModel?.fieldName, ":created_at")

                            expectation.fulfill()
                        }
                    }
                }
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
    
    func testSubwayLineViewModel() {
        // Given
        let expectation = XCTestExpectation(description: "Subway Result should return list of Lines")
        var subwayResult: SubwayResult? = nil
        let mockRequest = SubwayRequestLocal()
        mockRequest.parameters?["timestamp"] = 1616694129000
        
        // When
        SubwayUtility.subwayJSONObject(mockRequest) { response in
            if let result = response.result {
                if let subway = SubwayResult(json: result) {
                    
                    subwayResult = subway
                    
                    if let subwayResult = subwayResult {
                        
                        let listOfSubwayLines = subwayResult.listOfSubwayLines()
                        
                        XCTAssertEqual(listOfSubwayLines.count, 25)
                        
                        expectation.fulfill()
                    }
                }
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
    
    func testSubwayLineViewModelFilter() {
        // Given
        let expectation = XCTestExpectation(description: "Subway Result should return list of Lines Filtered")
        var subwayResult: SubwayResult? = nil
        let mockRequest = SubwayRequestLocal()
        mockRequest.parameters?["timestamp"] = 1616694129000
        
        // When
        SubwayUtility.subwayJSONObject(mockRequest) { response in
            if let result = response.result {
                if let subway = SubwayResult(json: result) {
                    
                    subwayResult = subway
                    
                    if let subwayResult = subwayResult {                        
                        let filteredList = subwayResult.filterList(with: "G")
                        
                        XCTAssertEqual(filteredList.count, 90)
                        
                        expectation.fulfill()
                    }
                }
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
}
