//
//  DetailViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 3.05.2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailPriceLabel: UILabel!
    
    @IBOutlet weak var detailDescTextView: UITextView!

    var product: SaleProductModel!
    
    override func viewDidLoad() {
        print(product)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func detailCommentBtn(_ sender: UIButton) {
    }
    
}
