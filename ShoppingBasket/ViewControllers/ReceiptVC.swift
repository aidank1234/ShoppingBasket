//
//  ViewController.swift
//  ShoppingBasket
//
//  Created by Aidan Kaiser on 1/31/20.
//  Copyright © 2020 Aidan Kaiser. All rights reserved.
//

import UIKit

class ReceiptVC: UIViewController {
    var receiptVM: ReceiptVM = ReceiptVM([])
    
    @IBOutlet weak var receiptText: UITextView!
    
    func bindToVM() {
        //Get Output string
        self.receiptVM.generateOutputString = {[weak self] (outputString) in
            self?.receiptText.text = outputString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptText.text = "..."
        bindToVM()
        receiptVM.getOutputString()
    }
}

