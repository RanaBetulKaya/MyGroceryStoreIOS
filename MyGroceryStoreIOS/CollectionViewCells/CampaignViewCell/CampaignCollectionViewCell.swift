//
//  CampaignCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 29.04.2024.
//

import UIKit

class CampaignCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: CampaignCollectionViewCell.self)
    
    @IBOutlet weak var CampaignPriceLabel: UILabel!
    @IBOutlet weak var CampaignDescLabel: UILabel!
    @IBOutlet weak var CampaignNameLabel: UILabel!
    @IBOutlet weak var CampaignImageView: UIImageView!
    
    func setup(product: SaleProductModel){
        CampaignImageView.kf.setImage(with: product.img_url?.asURL)
        CampaignNameLabel.text=product.name
        CampaignDescLabel.text=product.description
        CampaignPriceLabel.text=product.formattedPrice+"₺"
    }

}
