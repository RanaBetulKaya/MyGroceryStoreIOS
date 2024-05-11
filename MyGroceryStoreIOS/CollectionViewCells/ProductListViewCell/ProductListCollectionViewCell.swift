//
//  ProductListCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 10.05.2024.
//

import UIKit

protocol ProductListViewCellDelegate: AnyObject {
    func didTapDetailButton(product: SaleProductModel)
}

class ProductListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productDescTextView: UITextView!
    @IBOutlet weak var detailBtn: UIButton!
    
    weak var delegate: ProductListViewCellDelegate?
    
    var product: SaleProductModel!
    
    func setup(with product: SaleProductModel){
        
        self.product=product
        
        productNameLbl.text=product.name
        
        productImageView.kf.setImage(with: product.img_url?.asURL)
        
        productDescTextView.text=product.description
        
        detailBtn.addTarget(self, action: #selector(detailButtonTapped), for: .allEvents)
    
    }
    @objc func detailButtonTapped() {
            // Butona tıklandığında burası çalışacak
        let product = SaleProductModel(campaign: product.campaign, description: product.description, img_url: product.img_url, name: product.name, type: product.type, price: product.price)
            delegate?.didTapDetailButton(product: product)
        }
    
}
