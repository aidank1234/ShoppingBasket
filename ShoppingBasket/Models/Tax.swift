//
//  Tax.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 2/3/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import Foundation


class Tax {
    var importTax: Double
    var salesTax: Double
    var totalTax: Double
    static var allItemTaxes: Double = 0.0
    
    init(imported: Bool, exempt: Bool, price: Double) {
        self.importTax = 0.0
        self.salesTax = 0.0
        self.totalTax = 0.0
        if exempt == false {
            self.salesTax = self.roundNearestNickel(tax: price * 0.1)
        }
        if imported == true {
            self.importTax = self.roundNearestNickel(tax: price * 0.05)
        }
        self.totalTax = self.salesTax + self.importTax
        Tax.allItemTaxes += self.totalTax
    }
    
    private func roundNearestNickel(tax: Double) -> Double {
        return round(tax * 20) / 20
    }
}
