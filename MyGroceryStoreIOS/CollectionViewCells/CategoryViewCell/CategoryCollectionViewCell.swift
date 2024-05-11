//
//  CategoryCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 10.05.2024.
//

import UIKit
import Kingfisher

protocol CategoryCellDelegate: AnyObject {
    func didTapCategoryButton(category: HomeCategoryModel)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryTitleBtn: UIButton!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    weak var delegate: CategoryCellDelegate?

    var category : HomeCategoryModel!
    
    func setup(with category: HomeCategoryModel){
        
        self.category=category
        
        categoryTitleBtn.setTitle(category.name, for: .normal)
        
        categoryTitleBtn.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        categoryImageView.isUserInteractionEnabled = true 
        
        categoryImageView.kf.setImage(with: category.img_url.asURL)
    }
    @objc func categoryButtonTapped() {
            // Butona tıklandığında burası çalışacak
            guard let categoryTitle = categoryTitleBtn.title(for: .normal) else { return }
        let category = HomeCategoryModel(img_url: category.img_url , type: category.type, name: categoryTitle)
            delegate?.didTapCategoryButton(category: category)
        }
}
