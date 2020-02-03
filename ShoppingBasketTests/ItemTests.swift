//
//  ItemTests.swift
//  ShoppingBasketTests
//
//  Created by Aidan Kaiser on 2/3/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import XCTest

class ItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testItemline() {
        let itemTax = Tax(imported: false, exempt: false, price: 45.65)
        let item = Item(basePrice: 45.65, name: "Test Item", tax: itemTax)
        let itemLine = item.generateItemLine()
        XCTAssertEqual(itemLine, "Test Item: 50.20\n")
    }
    
    func testItemPricesCombined() {
        let itemTax = Tax(imported: false, exempt: false, price: 45.65)
        let item = Item(basePrice: 45.65, name: "Test Item", tax: itemTax)
        let item2 = Item(basePrice: 50.03, name: "Test Item 2", tax: itemTax)
        XCTAssertEqual(Item.pricesCombined, 95.68)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
