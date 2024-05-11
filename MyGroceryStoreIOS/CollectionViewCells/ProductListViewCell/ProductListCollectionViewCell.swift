//
//  ProductListCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 10.05.2024.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productDescTextView: UITextView!
    
    func setup(with product: SaleProductModel){
        
        productNameLbl.text=product.name
        
        productImageView.kf.setImage(with: product.img_url?.asURL)
        
        productDescTextView.text=product.description
    
    }
    
}
