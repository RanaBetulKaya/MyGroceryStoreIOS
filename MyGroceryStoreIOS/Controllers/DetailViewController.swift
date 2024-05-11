//
//  DetailViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 11.05.2024.
//

import UIKit

class DetailViewController: UIViewController {

    var product: SaleProductModel!
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailPriceLbl: UILabel!
    @IBOutlet weak var detailDescTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.kf.setImage(with: product.img_url?.asURL)
        detailPriceLbl.text = product.formattedPrice + " ₺"
        detailDescTextField.text = product.description
        //print(product.name)
        print("Detail girdi")
        
        // Do any additional setup after loading the view.
    }
    


}
