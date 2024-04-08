//
//  SalesCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 8.04.2024.
//

import UIKit

class SalesCollectionViewCell: UICollectionViewCell {

    static let identifier = "SalesCollectionViewCell"
    
    @IBOutlet weak var salesImageView: UIImageView!
    
    @IBOutlet weak var salesNameLabel: UILabel!
    
    @IBOutlet weak var salesDescLabel: UILabel!
    @IBOutlet weak var salesPriceLabel: UILabel!
    
    func setup(product: SaleProductModel){
        salesImageView.kf.setImage(with: product.img_url?.asURL)
        salesNameLabel.text = product.name
        salesDescLabel.text = product.description
        salesPriceLabel.text = product.formattedPrice
    }
    
}
