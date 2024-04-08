//
//  CategoryCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 8.04.2024.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleTextview: UITextView!
    
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    func setup(category: HomeCategoryModel){
        categoryTitleTextview.text=category.name
        categoryImageView.kf.setImage(with: category.img_url.asURL)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
