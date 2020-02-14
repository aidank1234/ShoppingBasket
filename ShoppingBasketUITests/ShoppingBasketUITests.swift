//
//  ShoppingBasketUITests.swift
//  ShoppingBasketUITests
//
//  Created by Aidan Kaiser on 1/31/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import XCTest

class ShoppingBasketUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoToCartButtonPresent() {
        XCTAssertTrue(app.buttons["Go to Cart"].exists)
    }
    
    func testReceiptTextPresent() {
        XCTAssertTrue(app.textViews.count == 0)
        app.buttons["Go to Cart"].tap(withNumberOfTaps: 1, numberOfTouches: 1)
        XCTAssertTrue(app.textViews.count == 1)
    }
    
    func testCorrectNumberOfCellsPresent() {
        XCTAssertTrue(app.tables.cells.count == 9)
    }
    
    func testSelectItemsLabelPresent() {
        XCTAssertTrue(app.staticTexts["Select Items (Before Tax)"].exists)
    }
    
    func testReceiptLabelPresent() {
        app.buttons["Go to Cart"].tap(withNumberOfTaps: 1, numberOfTouches: 1)
        XCTAssertTrue(app.staticTexts["Receipt (After Tax)"].exists)
    }
    
    func testDynamicReceiptText() {
        app.tables.cells.element(boundBy: 0).tap()
        app.tables.cells.element(boundBy: 1).tap()
        app.buttons["Go to Cart"].tap(withNumberOfTaps: 1, numberOfTouches: 1)
        let expectedString = "1 16lb bag of Skittles: 16.00\n1 Walkman: 109.99\nSales Taxes: 10.00\nTotal: 125.99"
        XCTAssertTrue(app.textViews.element(boundBy: 0).value as! String == expectedString)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.tables.cells.element(boundBy: 0).tap()
        app.tables.cells.element(boundBy: 6).tap()
        app.tables.cells.element(boundBy: 7).tap()
        app.buttons["Go to Cart"].tap(withNumberOfTaps: 1, numberOfTouches: 1)
        let expectedString2 = "1 Walkman: 109.99\n1 Discman: 60.50\n1 imported bottle of wine: 11.50\nSales Taxes: 17.00\nTotal: 181.99"
        XCTAssertTrue(app.textViews.element(boundBy: 0).value as! String == expectedString2)
    }
}
