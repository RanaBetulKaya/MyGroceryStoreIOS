//
//  DetailViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 11.05.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DetailViewController: UIViewController {

    var product: SaleProductModel!
    
    var productCountInt = 1
    
    var productDetail: MyCartModel!
    
    var db = Firestore.firestore()
    
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailPriceLbl: UILabel!
    @IBOutlet weak var detailDescTextField: UITextView!
    @IBAction func commentBtn(_ sender: Any) {
        
    }
    @IBAction func addToCart(_ sender: Any) {
        addToCart()
    }
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
        print(product.name)
        print("Detail girdi")
        print(product.documentID as Any)
        // Do any additional setup after loading the view.
    }
    func showProductCount () {
        productCount.text = "\(productCountInt)"
    }
    
    func addToCart() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user not found")
            return
        }
        print(currentUserID)
        let currentUserRef = db.collection("CurrentUser").document(currentUserID)
        let addToCartRef = currentUserRef.collection("AddToCart").document()

        let data: [String: Any] = [
            "productName": product.name ?? "",
            "totalQuantity": productCountInt,
            "totalPrice": (product.price!) * productCountInt
        ]

        addToCartRef.setData(data) { error in
            if let error = error {
                print("Error adding document to cart: \(error)")
            } else {
                print("Document added to cart successfully")
            }
        }
    }


}
