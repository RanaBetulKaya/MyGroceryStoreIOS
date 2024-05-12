//
//  CommentViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 11.05.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class CommentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var comments: [CommentModel] = []
    var db = Firestore.firestore()
    var ref: DatabaseReference!
    var product: String!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func sendCommentBtn(_ sender: Any) {
        sendComment()
        commentTextField.text = " "
    }
    @IBOutlet weak var commentCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(fromURL: "https://my-grocery-store-c4018-default-rtdb.europe-west1.firebasedatabase.app/")
        
        commentCollectionView.delegate=self
        commentCollectionView.dataSource=self
        
        print("Comment girdi")
        print(product)
        // Do any additional setup after loading the view.
        
        db.collection("AllProducts").document(product).collection("Comments").addSnapshotListener{ querySnapshot, error in guard let snapshot = querySnapshot else{ print("Error retriving snapshots \(error!)")
                return
            }
                for document in snapshot.documents{
                    let commentID = document.documentID
                    print(document.data())
                    let data = document.data()
                    let product_desc = data["comment"] as? String ?? ""
                    let userName = data["user"] as? String ?? ""
                    if !self.comments.contains(where: { $0.commentID == commentID }) {
                        self.comments.append(CommentModel(userName: userName, productDesc: product_desc, commentID: commentID))
                    }
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
    func sendComment(){
        // Kullanıcı adını al
        /*ref.child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userData = snapshot.value as? [String: Any] {
                // Kullanıcı verilerini al
                let name = userData["name"] as? String ?? ""
                print("İsim gelmeli?")
                print(name as Any)
            }
            }) { (error) in
                print("Firebase veri alımı başarısız: \(error.localizedDescription)")
            }*/
        let productComment = commentTextField.text
        getUserName { [self] name in
            if let userName = name {
                print("Kullanıcı adı: \(userName)")
                let comment = ["user": userName,
                               "comment": productComment]
                db.collection("AllProducts").document(product).collection("Comments").document().setData(comment){ error in
                    if let error = error{
                        print("Error adding document to cart: \(error)")
                    } else {
                        print("Document added to cart successfully")
                        self.showAlertMessage(title: "Başarılı", message: "Yorumunuz başarıyla gönderildi.")
                    }
                }
                
            } else {
                print("Kullanıcı adı alınamadı.")
            }
        }
        //commentCollectionView.reloadData()
    }
    func getUserName(completion: @escaping (String?) -> Void) {
        ref.child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userData = snapshot.value as? [String: Any] {
                // Kullanıcı verilerini al
                let name = userData["name"] as? String ?? ""
                print("İsim gelmeli?")
                print(name as Any)
                completion(name)
            } else {
                completion(nil)
            }
        }) { (error) in
            print("Firebase veri alımı başarısız: \(error.localizedDescription)")
            completion(nil)
        }
    }

}
