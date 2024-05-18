//
//  MyCartViewController.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 7.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MyCartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CartCollectionViewCellDelegate {
    
    var db = Firestore.firestore()
    var cartProducts: [MyCartModel] = []

    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    func didTapDeleteButton(product: MyCartModel) {
        print("Fonk' a  girdikkkkkk")
        print("ürün id: " ,product.cartProductID)
        db.collection("CurrentUser").document(Auth.auth().currentUser!.uid).collection("AddToCart").document(product.cartProductID!).delete(){ error in
            if let error = error{
                self.showAlertMessage(title: "Hata", message: "Ürün silinmedi. Tekrar deneyiniz.")
            } else{
                self.showAlertMessage(title: "", message: "Ürün sepetten çıkarıldı.")
                // cartProducts dizisinden ürünü sil
                           if let index = self.cartProducts.firstIndex(where: { $0.cartProductID == product.cartProductID }) {
                               self.cartProducts.remove(at: index)
                           }
                           
                           // Collection view'i güncelle
                           self.cartCollectionView.reloadData()
                           print("ürün silindi ve collection view güncellendi")
            }
            print("ürün silindi")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        cartCollectionView.delegate=self
        cartCollectionView.dataSource=self
        
        fetchProductData()
    }
    func fetchProductData(){
        // Veri çekme
        db.collection("CurrentUser").document(Auth.auth().currentUser!.uid).collection("AddToCart").addSnapshotListener{ querySnapshot, error in guard let snapshot = querySnapshot else { print("Error retriving snapshots \(error!)")
            return
        }
            print("vt bağlandı")
            for document in snapshot.documents{
                print(document.data())
                let cartProductID = document.documentID
                let data = document.data()
                let productName = data["productName"] as? String ?? ""
                let totalQuantity = data["totalQuantity"] as? Int ?? 0
                let totalPrice = data["totalPrice"] as? Int ?? 0
                if !self.cartProducts.contains(where: { $0.cartProductID == cartProductID }) {
                self.cartProducts.append(MyCartModel(productName: productName, totalPrice: totalPrice, totalQuantity: totalQuantity, cartProductID: cartProductID))
                }
                
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
        cell.delegate = self
        print("cellForItemAt ")
        return cell
    }
    

}
