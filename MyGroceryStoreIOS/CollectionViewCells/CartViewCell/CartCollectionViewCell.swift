//
//  CartCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 13.05.2024.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
    var productCart: MyCartModel!
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productQuantityLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    func setup(with productCart: MyCartModel){
        self.productCart = productCart
        let totalPriceString = "\(productCart.totalPrice ?? 0)"
        let totalQuantityString = "\(productCart.totalQuantity ?? 0)"
        productNameLbl.text = productCart.productName
        productQuantityLbl.text = totalQuantityString
        totalPriceLbl.text = totalPriceString
    }
    
}
