//
//  Unicorn_BooksUITests.swift
//  Unicorn BooksUITests
//
//  Created by Robert Taylor on 19/08/2021.
//

import XCTest

class Unicorn_BooksUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
    func testHomePage() throws {
        let homePageTitle = app.navigationBars["Unicorn Books"]
        XCTAssert(homePageTitle.exists)
    }
    
    func testTabBarAddBookButton() throws {
        let tabBarQuery = app.tabBars
        tabBarQuery.buttons["Add Book"].tap()
        let searchBar = app.textFields["Search Text Field"]
        XCTAssert(searchBar.exists)
    }
    
    func testKeyboardAppear() throws {
        let addBookTabItem = app.tabBars.buttons["Add Book"]
        addBookTabItem.tap()
        let searchBar = app.textFields["Search Text Field"]
        searchBar.tap()
        XCTAssert(app.keyboards.buttons["Go"].exists)
    }
    
    
    
}
