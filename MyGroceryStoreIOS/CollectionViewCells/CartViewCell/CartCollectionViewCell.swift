//
//  CartCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 13.05.2024.
//

import UIKit

protocol CartCollectionViewCellDelegate: AnyObject {
    func didTapDeleteButton(product: MyCartModel)
}

class CartCollectionViewCell: UICollectionViewCell {
    
    var productCart: MyCartModel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productQuantityLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    weak var delegate: CartCollectionViewCellDelegate?
    
    func setup(with productCart: MyCartModel){
        self.productCart = productCart
        let totalPriceString = "\(productCart.totalPrice ?? 0)"
        let totalQuantityString = "\(productCart.totalQuantity ?? 0)"
        productNameLbl.text = productCart.productName
        productQuantityLbl.text = totalQuantityString
        totalPriceLbl.text = totalPriceString
        deleteBtn.addTarget(self, action: #selector(deleteFromCart), for: .touchUpInside)
    }
    @objc func deleteFromCart(){
       // print("document id: ", productCart.documentID)
        print("delete girdi")
        let product = MyCartModel(productName: productCart.productName, totalPrice: productCart.totalPrice, totalQuantity: productCart.totalQuantity, cartProductID: productCart.cartProductID)
        delegate?.didTapDeleteButton(product: product)
        print("delegate çıktı")
    }
}
