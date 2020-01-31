//
//  ViewController.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 1/31/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentSelection = 0
    var oStrings: [String] = []
    @IBOutlet weak var shoppingListLabel: UILabel!
    @IBOutlet weak var receiptText: UITextView!
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBAction func previous(_ sender: Any) {
        if currentSelection > 0 {
            nextButton.isEnabled = true
            currentSelection -= 1
            receiptText.text = oStrings[currentSelection]
            shoppingListLabel.text = "Receipt \(currentSelection + 1)"
        }
        if currentSelection == 0 {
            previousButton.isEnabled = false
        }
    }
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBAction func next(_ sender: Any) {
        if currentSelection < 2 {
            previousButton.isEnabled = true
            currentSelection += 1
            receiptText.text = oStrings[currentSelection]
            shoppingListLabel.text = "Receipt \(currentSelection + 1)"
        }
        if currentSelection == 2 {
            nextButton.isEnabled = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oStrings = generateOutputStrings()
        previousButton.isEnabled = false
        receiptText.text = oStrings[0]
        shoppingListLabel.text = "Receipt \(currentSelection + 1)"
    }
    
    private func generateOutputStrings() -> [String] {
        var outputStrings: [String] = []
        do {
            let path = Bundle.main.path(forResource: "shopping", ofType: "json")
            let fileUrl = URL(fileURLWithPath: path!)
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let json = try JSON(data: data)
            var output1 = generateItemLines(json: json, basket: "b1")
            output1 = output1 + "Sales Taxes: " + String(format: "%.02f", Item.taxPaid) + "\n"
            output1 = output1 + "Total: " + String(format: "%.02f", Item.taxPaid + Item.pricesCombined) + "\n"
            Item.resetStatics()
            var output2 = generateItemLines(json: json, basket: "b2")
            output2 = output2 + "Sales Taxes: " + String(format: "%.02f", Item.taxPaid) + "\n"
            output2 = output2 + "Total: " + String(format: "%.02f", Item.taxPaid + Item.pricesCombined) + "\n"
            Item.resetStatics()
            var output3 = generateItemLines(json: json, basket: "b3")
            output3 = output3 + "Sales Taxes: " + String(format: "%.02f", Item.taxPaid) + "\n"
            output3 = output3 + "Total: " + String(format: "%.02f", Item.taxPaid + Item.pricesCombined) + "\n"
            Item.resetStatics()
            outputStrings.append(output1)
            outputStrings.append(output2)
            outputStrings.append(output3)
            
        }
        catch {
            print("Error reading JSON file. No receipt will display on the screen")
        }
        return outputStrings
    }

    private func generateItemLines(json: JSON, basket: String) -> String {
        var tempString = ""
        if let items = json[basket].array {
            for item in items {
                let newItem = Item(basePrice: item["price"].double!, imported: item["imported"].bool!, name: item["name"].string!, exempt: item["exempt"].bool!)
                tempString = tempString + newItem.generateItemLine()
            }
        }
        return tempString
    }
}

