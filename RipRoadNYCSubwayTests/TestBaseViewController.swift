//
//  TestBaseViewController.swift
//  RipRoadNYCSubwayTests
//
//  Created by Daniel Spady on 2021-04-01.
//

import XCTest
@testable import RipRoadNYCSubway

class TestBaseViewController: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBaseViewControllerLoadData() {
        // Given
        class MockViewController: BaseViewController {
            
            var tableView: UITableView = UITableView()
            var errorView: UIView = UIView()
            var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
            
            override func viewDidLoad() {
                super.viewDidLoad()
                self.loadData(for: tableView, collectionView: collectionView, errorView: errorView)
            }
        }
        
        let mockViewController = MockViewController()
        
        // When
        mockViewController.viewDidLoad()
        
        //Then
        XCTAssertTrue(mockViewController.errorView.isHidden)
    }
}
