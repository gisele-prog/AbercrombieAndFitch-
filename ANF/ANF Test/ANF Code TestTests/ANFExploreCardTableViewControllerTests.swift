import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {

    var testInstance: ANFExploreCardTableViewController!
    
    let mockProduct = [
        ProductCard(title: "TOPS STARTING AT $12",
                   backgroundImage:  "anf-20160527-app-m-shirts.jpg",
                    content: [
                        ProductCard.Content(target: "https://www.abercrombie.com/shop/us/mens-new-arrivals",
                                            title: "Shop Men")
                    ],
                    promoMessage: "USE CODE: 12345",
                    topDescription: "A&F ESSENTIALS",
                    bottomDescription: "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
                   )
    ]
    
    override func setUpWithError() throws {
        testInstance = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ANFExploreCardTableViewController") as? ANFExploreCardTableViewController
        testInstance.loadViewIfNeeded()
    }

    func testTableViewExists() {
        XCTAssertNotNil(testInstance.tableView, "The table view should exist.")
    }
   
    func testViewControllerDisplayData() {
        testInstance.viewModel.products = mockProduct
        testInstance.tableView.reloadData()
        
        let numberOfRows = testInstance.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, mockProduct.count, "table view should have 10 cells")
        
    }

    func test_numberOfSections_ShouldBeOne() {
        let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
        XCTAssert(numberOfSections == 1, "table view should have 1 section")
    }
    func test_numberOfRows_ShouldBeTen() {
        let numberOfRows = testInstance.tableView(testInstance.tableView, numberOfRowsInSection: 0)
        XCTAssert(numberOfRows ==  testInstance.viewModel.products.count, "table view should have 10 cells")
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldNotBeBlank() {
        let firstCell = testInstance.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProductCardTC
        firstCell?.configure(with: mockProduct[0], onLayoutUpdated: {
            let title = firstCell?.titleLbl as? UILabel
            XCTAssert(title?.text?.count ?? 0 > 0, "title should not be blank")
        })
        
    }
    
    func test_cellForRowAtIndexPath_ImageViewImage_shouldNotBeNil() {
        let firstCell = testInstance.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProductCardTC
        firstCell?.configure(with: mockProduct[0], onLayoutUpdated: {
            let imageView = firstCell?.productImgVw as? UIImageView
            XCTAssert(imageView?.image != nil, "image view image should not be nil")
        })
       
    }
}
