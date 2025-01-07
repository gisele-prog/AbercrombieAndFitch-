import XCTest
@testable import ANF_Code_Test

final class ProductsViewModelTests: XCTestCase {
    
    func textViewModelFetch() {
        let viewModel = ProductViewModel()
        let expectation = XCTestExpectation(description: "Fetch products in viewmodel")
        
        viewModel.fetchProducts { error in
            XCTAssertNil(error)
            XCTAssertFalse(viewModel.products.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
