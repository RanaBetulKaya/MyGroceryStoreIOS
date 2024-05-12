//
//  CommentCollectionViewCell.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 11.05.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase

class CommentCollectionViewCell: UICollectionViewCell {
    
    var db = Firestore.firestore()
    var comment: CommentModel!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var productDescLbl: UILabel!
    
    func setup(with comment: CommentModel){
        self.comment=comment
        userNameLbl.text = comment.userName
        productDescLbl.text = comment.productDesc
    }
    
}
