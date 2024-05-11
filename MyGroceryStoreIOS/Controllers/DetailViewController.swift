//
//  DetailViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 11.05.2024.
//

import UIKit

class DetailViewController: UIViewController {

    var product: SaleProductModel!
    
    var productCountInt = 1
    
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailPriceLbl: UILabel!
    @IBOutlet weak var detailDescTextField: UITextView!
    @IBAction func addBtn(_ sender: Any) {
        if productCountInt < 10{
            productCountInt+=1
        }
        else{
            showAlertMessage(title: "Uyarı !", message: "Sepete en fazla 10 ürün ekleyebilirsiniz")
        }
        showProductCount()
    }
    @IBAction func removeBtn(_ sender: Any) {
        if productCountInt > 1{
            productCountInt-=1
        }
        else{
            showAlertMessage(title: "Uyarı !", message: "Sepete en az 1 ürün eklemelisiniz")
        }
        showProductCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.kf.setImage(with: product.img_url?.asURL)
        detailPriceLbl.text = product.formattedPrice + " ₺"
        detailDescTextField.text = product.description
        showProductCount()
        //print(product.name)
        print("Detail girdi")
        
        // Do any additional setup after loading the view.
    }
    func showProductCount () {
        productCount.text = "\(productCountInt)"
    }
    

}
