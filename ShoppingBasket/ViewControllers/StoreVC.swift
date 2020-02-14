//
//  StoreVCViewController.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 2/3/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import UIKit

class StoreVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var storeVM: StoreVM = StoreVM()
    
    var numItems = 0
    var jsonData: JSON?
    var selectedItems: [Item] = []
    
    @IBOutlet weak var itemTableView: UITableView!
    
    @IBAction func goToCart(_ sender: Any) {
        storeVM.moveToCart(navController: navigationController, selectedItems: selectedItems)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return storeVM.cellForRow(jsonData: jsonData, index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItems.append(storeVM.addSelected(jsonData: jsonData, index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedItems = storeVM.removeDeselected(jsonData: jsonData, index: indexPath.row, selected: selectedItems)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.dataSource = self
        itemTableView.delegate = self
        itemTableView.allowsMultipleSelection = true
        bindToVM()
        storeVM.initJSON()
    }
    
    func bindToVM() {
        self.storeVM.getJSONData = {[weak self] (jsonData) in
            self?.numItems = jsonData.numItems ?? 0
            self?.jsonData = jsonData.jsonData ?? JSON()
            self?.itemTableView.reloadData()
        }
    }

}
