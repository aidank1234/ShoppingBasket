//
//  StoreVCViewController.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 2/3/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import UIKit

class StoreVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var numItems = 0
    var jsonData: JSON?
    var selectedItems: [Item] = []
    @IBOutlet weak var itemTableView: UITableView!
    @IBAction func goToCart(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "receiptVC") as! ReceiptVC
        vc.items = selectedItems
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuse")
        if jsonData != nil {
            let jsonArray = jsonData!["items"].array!
            cell.textLabel?.text = jsonArray[indexPath.row]["name"].string!
            cell.detailTextLabel?.text = String(format: "%.02f", jsonArray[indexPath.row]["price"].double!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jsonArray = jsonData!["items"].array!
        let itemToAdd = Item(basePrice: jsonArray[indexPath.row]["price"].double!, name: jsonArray[indexPath.row]["name"].string!, tax: Tax(imported: jsonArray[indexPath.row]["imported"].bool!, exempt: jsonArray[indexPath.row]["exempt"].bool!, price: jsonArray[indexPath.row]["price"].double!))
        selectedItems.append(itemToAdd)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let jsonArray = jsonData!["items"].array!
        for (index, item) in selectedItems.enumerated() {
            if item.name == jsonArray[indexPath.row]["name"].string! {
                selectedItems.remove(at: index)
                Item.pricesCombined -= item.basePrice
                Tax.allItemTaxes -= item.tax.totalTax
            }
        }
    }
    
    func initJSON() {
        do {
            let path = Bundle.main.path(forResource: "shopping", ofType: "json")
            let fileUrl = URL(fileURLWithPath: path!)
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let json = try JSON(data: data)
            numItems = json["items"].array!.count
            jsonData = json
            itemTableView.reloadData()
        }
        catch {
            print("Error reading JSON file. No receipt will display on the screen")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.dataSource = self
        itemTableView.delegate = self
        itemTableView.allowsMultipleSelection = true
        initJSON()
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
