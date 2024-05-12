//
//  CommentViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 11.05.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CommentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var comments: [CommentModel] = []
    var db = Firestore.firestore()
    var product: String!
    
    @IBOutlet weak var commentCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentCollectionView.delegate=self
        commentCollectionView.dataSource=self
        
        print("Comment girdi")
        print(product)
        // Do any additional setup after loading the view.
        
        db.collection("AllProducts").document(product).collection("Comments").addSnapshotListener{ querySnapshot, error in guard let snapshot = querySnapshot else{ print("Error retriving snapshots \(error!)")
                return
            }
                for document in snapshot.documents{
                    print(document.data())
                    let data = document.data()
                    let product_desc = data["comment"] as? String ?? ""
                    let userName = data["user"] as? String ?? ""
                    self.comments.append(CommentModel(userName: userName, productDesc: product_desc))
                    print("for içinde")
                    print(product_desc)
                }
                self.commentCollectionView.reloadData()
            //}
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = commentCollectionView.dequeueReusableCell(withReuseIdentifier: "CommentCollectionViewCell", for: indexPath) as! CommentCollectionViewCell
        cell.setup(with: comments[indexPath.row])
        return cell
    }
    

}
