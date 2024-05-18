//
//  MyCartViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 7.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MyCartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var db = Firestore.firestore()
    var cartProducts: [MyCartModel] = []

    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        cartCollectionView.delegate=self
        cartCollectionView.dataSource=self
        
        // Veri çekme
        db.collection("CurrentUser").document(Auth.auth().currentUser!.uid).collection("AddToCart").addSnapshotListener{ querySnapshot, error in guard let snapshot = querySnapshot else { print("Error retriving snapshots \(error!)")
            return
        }
            print("vt bağlandı")
            for document in snapshot.documents{
                print(document.data())
                let data = document.data()
                let productName = data["productName"] as? String ?? ""
                let totalQuantity = data["totalQuantity"] as? Int ?? 0
                let totalPrice = data["totalPrice"] as? Int ?? 0
                
                self.cartProducts.append(MyCartModel(productName: productName, totalPrice: totalPrice, totalQuantity: totalQuantity))
                
                print("for içinde")
            }
            
            self.cartCollectionView.reloadData()
        //}
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionViewCell", for: indexPath) as! CartCollectionViewCell
        cell.setup(with: cartProducts[indexPath.row])
        print("cellForItemAt ")
        return cell
    }
    

}
