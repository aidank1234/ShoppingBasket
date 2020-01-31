//
//  Item.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 1/31/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import Foundation


class Item {
    static var taxPaid: Double = 0.0
    static var pricesCombined: Double = 0.0
    var totalPrice: Double
    var basePrice: Double
    var name: String
    
    init(basePrice: Double, imported: Bool, name: String, exempt: Bool) {
        self.name = name
        self.totalPrice = basePrice
        self.basePrice = basePrice
        Item.pricesCombined += basePrice
        var tax = 0.0
        if exempt == false {
           tax = totalPrice * 0.1
            tax = roundNearestNickel(tax: tax)
        }
        if imported == true {
            var importTax = totalPrice * 0.05
            importTax = roundNearestNickel(tax: importTax)
            tax += importTax
        }
        self.totalPrice += tax
        Item.taxPaid += tax
    }
    
    func generateItemLine() -> String {
        var itemLine = ""
        itemLine = itemLine + name
        itemLine = itemLine + ": "
        itemLine = itemLine + String(format: "%.02f", totalPrice)
        itemLine = itemLine + "\n"
        return itemLine
    }
    
    class func resetStatics() -> Void {
        taxPaid = 0
        pricesCombined = 0
    }
    
    private func roundNearestNickel(tax: Double) -> Double {
        return round(tax * 20) / 20
    }
}
