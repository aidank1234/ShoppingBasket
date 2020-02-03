//
//  TaxTests.swift
//  ShoppingBasketTests
//
//  Created by Aidan Kaiser on 2/3/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import XCTest

class TaxTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSalesTaxNoImport() {
        let taxNoImport = Tax(imported: false, exempt: false, price: 45.65)
        XCTAssertEqual(taxNoImport.totalTax, 4.55)
    }
    
    func testImportTaxNoSales() {
        let taxNoSales = Tax(imported: true, exempt: true, price: 45.65)
        XCTAssertEqual(taxNoSales.totalTax, 2.30)
    }
    
    func testBothTaxes() {
        let fullTax = Tax(imported: true, exempt: false, price: 45.65)
        XCTAssertEqual(fullTax.totalTax, 6.85)
    }
    
    func testNoTaxes() {
        let noTax = Tax(imported: false, exempt: true, price: 45.65)
        XCTAssertEqual(noTax.totalTax, 0.0)
    }
    
    func testTaxTotal() {
        let tax1 = Tax(imported: false, exempt: false, price: 45.65)
        let tax2 = Tax(imported: true, exempt: false, price: 89.42)
        XCTAssertEqual(Tax.allItemTaxes, 17.95)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
