//
//  StoreVMTests.swift
//  ShoppingBasketTests
//
//  Created by Aidan Kaiser on 2/14/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import XCTest

class StoreVMTests: XCTestCase {
    var storeVM: StoreVM = StoreVM()
    
    var numItems = 0
    var jsonData: JSON?
    var selectedItems: [Item] = []

    override func setUp() {
        self.storeVM.getJSONData = {(jsonData) in
            self.numItems = jsonData.numItems ?? 0
            self.jsonData = jsonData.jsonData ?? JSON()
        }
        self.storeVM.initJSON()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumItemsCorrect() {
        XCTAssertEqual(numItems, 9)
    }
    
    func testSelectDeselect() {
        self.selectedItems.append(self.storeVM.addSelected(jsonData: jsonData, index: 1))
        self.selectedItems = self.storeVM.removeDeselected(jsonData: jsonData, index: 1, selected: self.selectedItems)
        self.selectedItems.append(self.storeVM.addSelected(jsonData: jsonData, index: 2))
        XCTAssertEqual(selectedItems[0].name, "1 bag of microwave Popcorn")
        XCTAssertTrue(self.selectedItems.count == 1)
    }

    func testCellForRow() {
        let cell = self.storeVM.cellForRow(jsonData: jsonData, index: 3)
        XCTAssertEqual(cell.textLabel?.text, "1 imported bag of Vanilla-Hazelnut Coffee")
        XCTAssertEqual(cell.detailTextLabel?.text, "11.00")
    }

}
