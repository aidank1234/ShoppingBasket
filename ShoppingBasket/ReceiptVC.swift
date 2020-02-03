//
//  ViewController.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 1/31/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import UIKit

class ReceiptVC: UIViewController {
    var items: [Item] = []
    
    @IBOutlet weak var receiptText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptText.text = generateOutputString()
    }
    
    private func generateOutputString() -> String {
        var outputString: String = ""
        for item in items {
            outputString = outputString + item.generateItemLine()
        }
        outputString = outputString + "Sales Taxes: " + String(format: "%.02f", Tax.allItemTaxes) + "\n"
        outputString = outputString + "Total: " + String(format: "%.02f", Tax.allItemTaxes + Item.pricesCombined) + "\n"
        return outputString
    }
}

