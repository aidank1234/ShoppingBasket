//
//  ReceiptVMTests.swift
//  ShoppingBasketTests
//
//  Created by Aidan Kaiser on 2/14/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import XCTest

class ReceiptVMTests: XCTestCase {
    var items: [Item] = []
    private func initJSON() -> Void {
        do {
            let path = Bundle.main.path(forResource: "shopping", ofType: "json")
            let fileUrl = URL(fileURLWithPath: path!)
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let json = try JSON(data: data)
            let jsonArray = json["items"].array!
            for item in jsonArray {
                let constructedTax = Tax(imported: item["imported"].bool!, exempt: item["exempt"].bool!, price: item["price"].double!)
                let constructedItem = Item(basePrice: item["price"].double!, name: item["name"].string!, tax: constructedTax)
                items.append(constructedItem)
            }
        }
        catch {
            print("Error reading JSON file. No receipt will display on the screen")
        }
    }

    override func setUp() {
        items.removeAll()
        Item.pricesCombined = 0.0
        Tax.allItemTaxes = 0.0
        initJSON()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDisplayedReceipt() {
        var vm = ReceiptVM(items)
        let expected = "1 16lb bag of Skittles: 16.00\n1 Walkman: 109.99\n1 bag of microwave Popcorn: 0.99\n1 imported bag of Vanilla-Hazelnut Coffee: 11.55\n1 imported Vespa: 17251.45\n1 imported crate of Almond Snickers: 79.79\n1 Discman: 60.50\n1 imported bottle of wine: 11.50\n1 300# bag of Fair-Trade Coffee: 997.99\nSales Taxes: 2271.55\nTotal: 18539.76"
        var displayText = ""
        vm.generateOutputString = {(outputString) in
            displayText = outputString
        }
        vm.getOutputString()
        XCTAssertEqual(displayText, expected)
    }


}
