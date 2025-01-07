import XCTest
@testable import ANF_Code_Test

final class ProductsServiceTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
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
