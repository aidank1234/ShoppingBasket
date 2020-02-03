//
//  Item.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 1/31/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import Foundation


class Item {
    static var pricesCombined: Double = 0.0
    var totalPrice: Double
    var basePrice: Double
    var name: String
    var tax: Tax
    
    init(basePrice: Double, name: String, tax: Tax) {
        self.name = name
        self.tax = tax
        self.totalPrice = basePrice
        self.basePrice = basePrice
        Item.pricesCombined += basePrice
        self.totalPrice += tax.importTax
        self.totalPrice += tax.salesTax
    }
    
    func generateItemLine() -> String {
        var itemLine = ""
        itemLine = itemLine + name
        itemLine = itemLine + ": "
        itemLine = itemLine + String(format: "%.02f", totalPrice)
        itemLine = itemLine + "\n"
        return itemLine
    }
}
