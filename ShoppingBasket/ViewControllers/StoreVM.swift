//
//  StoreVM.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 2/10/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import Foundation
import UIKit

struct JSONData {
    var numItems: Int?
    var jsonData: JSON?
}

struct StoreVM {
    
    var getJSONData: ((JSONData) -> Void)?
    
    func initJSON() -> Void {
        do {
            let path = Bundle.main.path(forResource: "shopping", ofType: "json")
            let fileUrl = URL(fileURLWithPath: path!)
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let json = try JSON(data: data)
            self.getJSONData?(JSONData(numItems: json["items"].array!.count, jsonData: json))
        }
        catch {
            print("Error reading JSON file. No receipt will display on the screen")
            self.getJSONData?(JSONData(numItems: 0, jsonData: JSON()))
        }
    }
    
    func moveToCart(navController: UINavigationController?, selectedItems: [Item]) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "receiptVC") as! ReceiptVC
        vc.receiptVM = ReceiptVM(selectedItems)
        navController?.pushViewController(vc, animated: true)
    }
    
    func cellForRow(jsonData: JSON?, index: Int) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuse")
        if jsonData != nil {
            let jsonArray = jsonData!["items"].array!
            cell.textLabel?.text = jsonArray[index]["name"].string!
            cell.detailTextLabel?.text = String(format: "%.02f", jsonArray[index]["price"].double!)
        }
        return cell
    }
    
    func addSelected(jsonData: JSON?, index: Int) -> Item {
        let jsonArray = jsonData!["items"].array!
        let itemToAdd = Item(basePrice: jsonArray[index]["price"].double!, name: jsonArray[index]["name"].string!, tax: Tax(imported: jsonArray[index]["imported"].bool!, exempt: jsonArray[index]["exempt"].bool!, price: jsonArray[index]["price"].double!))
        return itemToAdd
    }
    
    func removeDeselected(jsonData: JSON?, index: Int, selected: [Item]) -> [Item] {
        let jsonArray = jsonData!["items"].array!
        var selectedItems = selected
        for (idx, item) in selected.enumerated() {
            if item.name == jsonArray[index]["name"].string! {
                selectedItems.remove(at: idx)
                Item.pricesCombined -= item.basePrice
                Tax.allItemTaxes -= item.tax.totalTax
            }
        }
        return selectedItems
    }
    
}
