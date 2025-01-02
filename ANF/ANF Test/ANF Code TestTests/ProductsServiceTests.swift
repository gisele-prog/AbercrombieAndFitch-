//
//  ProductsServiceTests.swift
//  ANF Code TestTests
//
//  Created by joie gisele mukamisha on 1/2/25.
//

import XCTest
@testable import ANF_Code_Test

final class ProductsServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchProducts() {
        let expectation = XCTestExpectation(description: "Fetch Products")
        ProductCardService.shared.fetchPromotions { result in
            switch result {
            case .success(let products):
                XCTAssertNotNil(products)
                XCTAssertFalse(products.isEmpty)
            case .failure(let error):
                XCTFail("Failed to fetch products: \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }

}
