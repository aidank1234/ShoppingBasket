//
//  ReceiptVM.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 2/10/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import Foundation

struct ReceiptVM {
    var generateOutputString: ((String) -> Void)?
    var items: [Item]?
    init(_ items: [Item]) {
        self.items = items
    }
    
    func getOutputString() -> Void {
        var outputString: String = ""
        for item in items ?? [] {
            outputString = outputString + item.generateItemLine()
        }
        outputString = outputString + "Sales Taxes: " + String(format: "%.02f", Tax.allItemTaxes) + "\n"
        outputString = outputString + "Total: " + String(format: "%.02f", Tax.allItemTaxes + Item.pricesCombined)
        self.generateOutputString?(outputString)
    }
    
}
